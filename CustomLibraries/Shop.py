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
        # Site: rahulshettyacademy.com/angularpractice/shop (ProtoCommerce)
        # Wait for cards to load
        self.seleniumLib.wait_until_element_is_visible("css:.card-title", "15s")
        time.sleep(1)

        # Get all card title and button elements by index
        title_elements = self.seleniumLib.get_webelements("css:.card-title")
        add_buttons = self.seleniumLib.get_webelements("css:.card-footer button")

        for i, title_el in enumerate(title_elements):
            title_text = title_el.text.strip()
            if title_text in itemsList:
                self.builtin.wait_until_keyword_succeeds(
                    "15s", "1s", "Click Element", add_buttons[i]
                )
                time.sleep(0.5)

        # Click the Checkout link in the navbar
        checkout_locator = "xpath://a[contains(.,'Checkout')]"
        self.seleniumLib.wait_until_element_is_visible(checkout_locator, "15s")
        self.builtin.wait_until_keyword_succeeds(
            "15s", "1s", "Click Element", checkout_locator
        )
