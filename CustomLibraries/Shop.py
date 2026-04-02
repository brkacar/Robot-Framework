from robot.api.deco import keyword, library
from robot.libraries.BuiltIn import BuiltIn
from SeleniumLibrary.keywords.element import ElementKeywords

@library
class Shop:
    def __init__(self):
        self.seleniumLib: ElementKeywords = (
            BuiltIn().get_library_instance("SeleniumLibrary"))

    @keyword
    def hello_world(self):
        print("Hello")

    @keyword
    def Add_Items_to_Card_and_Checkout(self, *itemsList): # * catches unpacked list as tuple
        i=1
        #Get WebElements
        items=self.seleniumLib.get_webelements("css=.card-title")
        for item in items:
            if item.text in itemsList:
                self.seleniumLib.click_button("(//*[ @class='card-footer'])["+str(i)+"]/button")
            i=i+1

        self.seleniumLib.click_link("css:li.active a")

