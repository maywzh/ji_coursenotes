import select
import socket
import struct
import socketserver
SOCKS_VERSION = 5


class SocksProxy(socketserver.StreamRequestHandler):
    def handle(self):
        print('Accepting connection from {}'.format(self.client_address))
        #协商
        #从客户端读取并解包两个字节的数据
        header = self.connection.recv(2)
        version, nmethods = struct.unpack("!BB", header)
        #设置socks5协议，METHODS字段的数目大于0
        assert version == SOCKS_VERSION
        assert nmethods > 0
        # 接受支持的方法
        methods = self.get_available_methods(nmethods)
        # 无需认证
        if 0 not in set(methods):
            self.server.close_request(self.request)
            return
        # 发送协商响应数据包
        self.connection.sendall(struct.pack("!BB", SOCKS_VERSION, 0))
        # 请求
        version, cmd, _, address_type = struct.unpack("!BBBB",
                                                      self.connection.recv(4))
        assert version == SOCKS_VERSION
        if address_type == 1:  #IPv4
            address = socket.inet_ntoa(self.connection.recv(4))
        elif address_type == 3:  #Domain name
            domain_length = self.connection.recv(1)[0]
            address = self.connection.recv(domain_length)
            # address = socket.gethostbyname(address.decode("UTF-8")) # 将域名转化为IP，可去掉
        elif address_type == 4:  #IPv6
            addr_ip = self.connection.recv(16)
            address = socket.inet_ntop(socket.AF_INET6, addr_ip)
        else:
            self.server.close_request(self.request)
        port = struct.unpack('!H', self.connection.recv(2))[0]
        # 响应，只支持CONNECT请求
        try:
            if cmd == 1:  #CONNECT
                remote = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                remote.connect((address, port))
                bind_address = remote.getsockname()
                print('Connected to {} {}'.format(address, port))
            else:
                self.server.close_request(self.request)
            addr = struct.unpack("!I", socket.inet_aton(bind_address[0]))[0]
            port = bind_address[1]
            reply = struct.pack("!BBBBIH", SOCKS_VERSION, 0, 0, address_type,
                                addr, port)
            # reply = struct.pack("!BBBBIH", SOCKS_VERSION, 0, 0, 1, addr, port)
            # 注意：按照标准协议，返回的应该是对应的address——type，但是实际测试发现，当address——type=3，也就是说域名类型时，会出现卡死情况但是将address——type设为1，则不管是IP类型还是域名类型都能正常运行
            # reply = self.generate_failed_reply(address_type, 5)
        except Exception as err:
            # logging.error(err)    #写日志
            # 响应拒绝连接的错误
            reply = self.generate_failed_reply(address_type, 5)
            print('fail connnect')
        self.connection.sendall(reply)
        #   建立连接成功，开始交换数据
        if reply[1] == 0 and cmd == 1:
            print('Begin data exchange')
            self.exchange_loop(self.connection, remote)
            print('Data exchanged')
        self.server.close_request(self.request)

    def get_available_methods(self, n):
        methods = []
        for i in range(n):
            methods.append(ord(self.connection.recv(1)))
        return methods

    def generate_failed_reply(self, address_type, error_number):
        return struct.pack("!BBBBIH", SOCKS_VERSION, error_number, 0,
                           address_type, 0, 0)

    def exchange_loop(self, client, remote):
        while True:
            print('Waiting for data')
            #   等待数据
            r, w, e = select.select([client, remote], [], [])
            print('Data received, Begin exchanging data')
            print('r:', r)
            print('w:', w)
            print('e:', e)
            if client in r:
                data = client.recv(4096)
                if remote.send(data) <= 0:
                    break
            if remote in r:
                data = remote.recv(4096)
                if client.send(data) <= 0:
                    break


if __name__ == '__main__':
    #   使用socketserver库的多线程服务器ThreadingTCPServer启动代理
    with socketserver.ThreadingTCPServer(('127.0.0.1', 9011),
                                         SocksProxy) as server:
        server.serve_forever()
