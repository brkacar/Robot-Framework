import os
from pathlib import Path

import allure
from robot.libraries.BuiltIn import BuiltIn


class AllureHelper:
    def attach_screenshot(self, path, name="Failure Screenshot"):
        if not path:
            return
        file_path = Path(path)
        if not file_path.is_absolute():
            file_path = Path(os.getcwd()) / file_path
        if file_path.exists():
            allure.attach.file(
                str(file_path),
                name=name,
                attachment_type=allure.attachment_type.PNG,
            )

    def capture_and_attach_screenshot(self, name="Failure Screenshot"):
        selenium = BuiltIn().get_library_instance("SeleniumLibrary")
        path = selenium.capture_page_screenshot()
        self.attach_screenshot(path, name)