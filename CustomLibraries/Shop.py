from robot.api.deco import keyword, library
from robot.libraries.BuiltIn import BuiltIn

@library
class Shop:
    def __init__(self):
        self.seleniumLib = BuiltIn().get_library_instance("SeleniumLibrary")
        self.builtin = BuiltIn()

    @keyword("Add Items To Card And Checkout")
    def Add_Items_to_Card_and_Checkout(self, *itemsList):
        # Get WebElements
        i = 1
        items = self.seleniumLib.get_webelements(" css:.card-title")
        for item in items:
            if item.text in itemsList:
                self.seleniumLib.click_button("xpath:(//*[@class='card-footer'])["+str(i)+"]/button")

            i = i + 1
        self.seleniumLib.thread.sleep(200)
        self.seleniumLib.click_link("css:li.active a")
