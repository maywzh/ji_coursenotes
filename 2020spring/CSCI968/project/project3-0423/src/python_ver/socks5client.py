from socketserver import ThreadingTCPServer, StreamRequestHandler
import socketserver, sscrypto
import socket, select, struct, random
from sscrypto import get_random_bytes
import sys


class ThreadingTCPServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    allow_reuse_address = True


class RequestHandler(StreamRequestHandler):
    def send_all(self, sock, data):
        bytes_sent = 0
        while True:
            r = sock.send(data[bytes_sent:])
            if r < 0:
                return r
            bytes_sent += r
            if bytes_sent == len(data):
                return bytes_sent

    # 转发tcp报文

    def handle_tcp(self, sock, remote, encryption, buff_size):
        try:
            fdset = [sock, remote]
            while True:
                r, w, e = select.select(fdset, [], [])
                if sock in r:
                    plain_data = sock.recv(buff_size)
                    if len(plain_data) <= 0:
                        break
                    data = encryption.encrypt(plain_data)
                    result = self.send_all(remote, data)
                    if result < len(data):
                        raise Exception('failed to send all data')
                if remote in r:
                    cipher_data = remote.recv(buff_size)
                    if len(cipher_data) <= 0:
                        break
                    data = encryption.decrypt(cipher_data)
                    result = self.send_all(sock, data)
                    if result < len(data):
                        raise Exception('failed to send all data')
        except Exception:
            sock.close()
            remote.close()

    def handle(self):
        print("socks5 connection from ", self.client_address)
        sock = self.connection
        PKT_BUFF_SIZE = 409600

        f = open("pks.pem", "rb")
        pks = sscrypto.DSA.import_key(f.read())
        f = open("skc.pem", "rb")
        dsakey = sscrypto.DSA.import_key(f.read())
        f.close()

        remote_conn = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            remote_conn.connect(('127.0.0.1', 7777))
        except Exception:
            sock.close()
            print('Error: Unable to connect to the remote server.')
            return

        p = 23
        g = 5
        ids = b'127.0.0.1'
        idc = b'127.0.0.1'

        a = random.randint(1, p - 2)
        u = pow(g, a, p)
        hu = struct.pack('!H', u)
        hash_obj = sscrypto.SHA256.new(hu)
        signer = sscrypto.DSS.new(dsakey, 'fips-186-3')
        signature = signer.sign(hash_obj)
        c1 = hu + signature
        remote_conn.send(c1)

        c2 = remote_conn.recv(58)
        v = c2[:2]
        hash_obj = sscrypto.SHA256.new(hu + v + ids)
        verifier = sscrypto.DSS.new(pks, 'fips-186-3')
        try:
            verifier.verify(hash_obj, c2[2:])
        except ValueError:
            print("The message is not authentic.")

        gb = struct.unpack('!H', v)[0]
        gab = pow(gb, a, p)
        kdf = struct.pack('!HHH10p10p', u, gb, gab, idc, ids)
        key = sscrypto.SHA256.new(kdf).digest()[:16]

        secret = get_random_bytes(16)
        remote_conn.send(secret)
        remote_conn.recv(2)

        remote_conn.send(sock.recv(262))
        sock.send(remote_conn.recv(2))
        message = sock.recv(4)
        remote_conn.send(message)
        version, CMD, RSV, ATYP = struct.unpack("!BBBB", message)
        if ATYP == 1:
            remote_conn.send(sock.recv(4))
        elif ATYP == 3:
            message = sock.recv(1)
            domain_length = message[0]
            remote_conn.send(message)
            remote_conn.send(sock.recv(domain_length))
        remote_conn.send(sock.recv(2))
        sock.send(remote_conn.recv(90))

        encryption = sscrypto.AES_GCM(key, secret)
        self.handle_tcp(sock, remote_conn, encryption, PKT_BUFF_SIZE)


# def main():

#     server = ThreadingTCPServer(('127.0.0.1', 7932), RequestHandler)

#     server.serve_forever()

# if __name__ == '__main__':
#     main()


def main(addr, port):
    server = ThreadingTCPServer((addr, port), RequestHandler)
    server.serve_forever()


if __name__ == '__main__':
    print("--Server 127.0.0.1:%s Start--" % sys.argv[1])
    main('127.0.0.1', int(sys.argv[1]))
