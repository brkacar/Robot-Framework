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

        cart_locator = "//a[contains(@href,'checkout') or contains(@href,'cart') or contains(.,'Checkout')]"
        self.seleniumLib.wait_until_element_is_visible(cart_locator, "10s")
        self.seleniumLib.wait_until_page_contains_element(cart_locator, "10s")

        self.seleniumLib.scroll_element_into_view(cart_locator)
        self.builtin.wait_until_keyword_succeeds(
            "15s", "2s", "Click Element", cart_locator
        )