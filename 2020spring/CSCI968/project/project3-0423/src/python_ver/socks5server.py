from socketserver import ThreadingTCPServer, StreamRequestHandler
import socketserver,sscrypto
import socket,select,struct,random
import sys

class ThreadingTCPServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    allow_reuse_address = True

class RequestHandler(StreamRequestHandler):

    def send_all(self,sock, data):
        bytes_sent = 0
        while True:
            r = sock.send(data[bytes_sent:])
            if r < 0:
                return r
            bytes_sent += r
            if bytes_sent == len(data):
                return bytes_sent
    
    def handle_tcp(self, sock, remote,encryption,buff_size):
        try:
            fdset = [sock, remote]
            while True:
                r, w, e = select.select(fdset, [], [])
                if sock in r:
                    cipher_data = sock.recv(buff_size)
                    if len(cipher_data) <= 0:
                        break
                    data=encryption.decrypt(cipher_data)
                    result = self.send_all(remote, data)
                    if result < len(data):
                        raise Exception('failed to send all data')
                if remote in r:
                    plain_data = remote.recv(buff_size)
                    if len(plain_data) <= 0:
                        break
                    data=encryption.encrypt(plain_data)
                    result = self.send_all(sock, data)
                    if result < len(data):
                        raise Exception('failed to send all data')
        except Exception:
            sock.close()
            remote.close()

    def handle(self):
        print("socks5 connection from ", self.client_address)
        sock = self.connection

        f = open("pkc.pem", "rb")
        pkc=sscrypto.DSA.import_key(f.read())
        f = open("sks.pem", "rb")
        dsakey = sscrypto.DSA.import_key(f.read())
        f.close()

        verifier = sscrypto.DSS.new(pkc, 'fips-186-3')
        c1=sock.recv(58)
        u=c1[:2]
        hash_obj = sscrypto.SHA256.new(u)
        try:
            verifier.verify(hash_obj, c1[2:])
        except ValueError:
            print("The message is not authentic.")

        p = 23
        g = 5
        ids = b'127.0.0.1'
        idc = b'127.0.0.1'

        b = random.randint(1, p - 2)
        v = pow(g, b, p)
        hv = struct.pack('!H', v)
        hash_obj = sscrypto.SHA256.new(u+hv+ids)
        signer = sscrypto.DSS.new(dsakey, 'fips-186-3')
        signature = signer.sign(hash_obj)
        c2 = hv + signature
        sock.send(c2)

        ga=struct.unpack('!H',u)[0]
        gab=pow(ga, b, p)
        kdf=struct.pack('!HHH10p10p',ga,v,gab,idc,ids)
        key = sscrypto.SHA256.new(kdf).digest()[:16]

        encryption = sscrypto.AES_GCM(key,sock.recv(16))
        sock.send(struct.pack("2B", 6, 1))

        sock.recv(262)
        sock.send(struct.pack("2B",5,0))

        version,CMD,RSV,ATYP=struct.unpack("!BBBB",sock.recv(4))
        if ATYP==1:
            DST_ADDR=socket.inet_ntoa(sock.recv(4))
        elif ATYP==3:
            domain_length=sock.recv(1)[0]
            DST_ADDR=sock.recv(domain_length)
        DST_PORT=struct.unpack(">H",sock.recv(2).strip())[0]

        try:
            if CMD==1:
                rep2=struct.pack("4B",5,0,0,1)
                remote=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
                remote.connect((DST_ADDR,DST_PORT))
                local = remote.getsockname()
                rep2 += socket.inet_aton(local[0]) + struct.pack(">H", local[1])
            else:
                rep2=struct.pack("4B",5,7,0,1)

        except socket.error:
            rep2=struct.pack("10B",5,3,0,1,0,0,0,0,0,0)
        sock.send(rep2)

        buff_size=409600

        if rep2[1]==0:
            print("success")
            self.handle_tcp(sock,remote,encryption,buff_size)
        else:
            sock.shutdown(socket.SHUT_RDWR)
            sock.close()


# def main():
#     server = ThreadingTCPServer(('127.0.0.1', 7933), RequestHandler)
#     server.serve_forever()
# if __name__ == '__main__':
#     main()


def main(addr,port):
    server = ThreadingTCPServer((addr, port), RequestHandler)
    server.serve_forever()


if __name__ == '__main__':
    print("--Server 127.0.0.1:%s Start--" % sys.argv[1])
    main('127.0.0.1',int(sys.argv[1]))