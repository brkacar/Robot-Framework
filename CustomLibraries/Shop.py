from robot.api.deco import keyword, library
from robot.libraries.BuiltIn import BuiltIn

@library
class Shop:
    def __init__(self):
        self.seleniumLib = BuiltIn().get_library_instance("SeleniumLibrary")


    @keyword
    def Add_Items_to_Card_and_Checkout(self, *itemsList): # * catches unpacked list as tuple
        i=1
        self.seleniumLib.wait_until_element_is_visible("css:.card-title", "10s")
        self.seleniumLib.wait_until_element_is_visible("css:li.active a", "10s")
        #Get WebElements
        items=self.seleniumLib.get_webelements("css=.card-title")
        for item in items:
            if item.text in itemsList:
                self.seleniumLib.click_button("(//*[ @class='card-footer'])["+str(i)+"]/button")
            i=i+1

        self.seleniumLib.click_link("css:li.active a")

