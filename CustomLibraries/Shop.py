from robot.api.deco import keyword, library
from robot.libraries.BuiltIn import BuiltIn
import time

@library
class Shop:
    def __init__(self):
        self.seleniumLib = BuiltIn().get_library_instance("SeleniumLibrary")
        self.builtin = BuiltIn()

    @keyword("Add Items To Card And Checkout")
    def Add_Items_to_Card_and_Checkout(self, *itemsList):
        # Wait for all ADD TO CART buttons to be present and interactable
        self.seleniumLib.wait_until_element_is_visible("css:.card-footer button", "15s")
        self.seleniumLib.wait_until_element_is_enabled("css:.card-footer button", "15s")
        time.sleep(1)

        # Get card titles and click matching ADD TO CART buttons
        items = self.seleniumLib.get_webelements("css:.card-title")
        for i, item in enumerate(items, start=1):
            if item.text in itemsList:
                btn_locator = "xpath:(//*[@class='card-footer'])[" + str(i) + "]/button"
                self.builtin.wait_until_keyword_succeeds(
                    "15s", "1s", "Click Button", btn_locator
                )

        # Click the cart icon to proceed to checkout
        cart_locator = "css:img[alt='Cart']"
        self.seleniumLib.wait_until_element_is_visible(cart_locator, "15s")
        self.seleniumLib.scroll_element_into_view(cart_locator)
        self.builtin.wait_until_keyword_succeeds(
            "15s", "2s", "Click Element", cart_locator
        )
