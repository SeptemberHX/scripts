from http.server import BaseHTTPRequestHandler, HTTPServer
from sys import argv


class Request(BaseHTTPRequestHandler):
    def handler(self):
        print("data:", self.rfile.readline().decode())
        self.wfile.write(self.rfile.readline())

    def do_POST(self):
        print(self.headers)
        print(self.command)
        req_datas = self.rfile.read(int(self.headers['content-length']))  # 重点在此步!
        print(req_datas.decode())
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        self.wfile.write('finished'.encode('utf-8'))


if __name__ == '__main__':
    port = 8080
    try:
        port = int(argv[1])
    except Exception as e:
        pass

    host = ('localhost', port)
    server = HTTPServer(host, Request)
    print("Starting server, listen at: %s:%s" % host)
    server.serve_forever()
