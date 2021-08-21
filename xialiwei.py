import time
import tornado.web

class HomeHandler(tornado.web.RequestHandler):
    def get(self):
        self.time_now = int(time.time())
        self.render("template/xialiwei.html")
