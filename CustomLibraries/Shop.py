from robot.api.deco import keyword, library

@library
class Shop:
     # def __init__(self):

    @keyword
    def hello_world(self):
        print("Hello")

