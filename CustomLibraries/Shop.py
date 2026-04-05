from robot.api.deco import keyword, library
from robot.libraries.BuiltIn import BuiltIn

@library
class Shop:
    def __init__(self):
        self.seleniumLib = BuiltIn().get_library_instance("SeleniumLibrary")
        self.builtin = BuiltIn()

    @keyword
    def Add_Items_to_Card_and_Checkout(self, *itemsList):
        self.seleniumLib.wait_until_element_is_visible("css:.card-title", "10s")

        for item_name in itemsList:
            button_locator = (
                f"xpath://h4[@class='card-title' and normalize-space()='{item_name}']"
                f"/ancestor::div[contains(@class,'card')]//button"
            )
            self.seleniumLib.wait_until_element_is_visible(button_locator, "10s")
            self.seleniumLib.scroll_element_into_view(button_locator)
            self.builtin.wait_until_keyword_succeeds(
                "10s", "1s", "Click Element", button_locator
            )

        cart_locator = "css:li.active a"
        self.seleniumLib.wait_until_element_is_visible(cart_locator, "10s")
        self.builtin.wait_until_keyword_succeeds(
            "10s", "1s", "Click Element", cart_locator
        )