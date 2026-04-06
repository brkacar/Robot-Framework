import os
import uuid
import shutil
from pathlib import Path
from robot.libraries.BuiltIn import BuiltIn
from robot.api.deco import keyword, library

try:
    import allure
    ALLURE_AVAILABLE = True
except ImportError:
    ALLURE_AVAILABLE = False

@library
class AllureHelper:

    @keyword("Attach Screenshot")
    def attach_screenshot(self, path, name="Failure Screenshot"):
        """Attach screenshot to Allure report - tries allure.attach first, then file copy fallback."""
        if not path:
            return
        file_path = Path(path)
        if not file_path.is_absolute():
            file_path = Path(os.getcwd()) / file_path
        if not file_path.exists():
            return

        # Method 1: use allure.attach with raw bytes (works when listener is active)
        if ALLURE_AVAILABLE:
            try:
                with open(str(file_path), "rb") as f:
                    image_bytes = f.read()
                allure.attach(image_bytes, name=name, attachment_type=allure.attachment_type.PNG)
                return
            except Exception:
                pass

        # Method 2: copy PNG directly into allure-results folder
        allure_results = Path(os.getcwd()) / "allure-results"
        allure_results.mkdir(parents=True, exist_ok=True)
        attachment_name = f"{uuid.uuid4()}-attachment.png"
        shutil.copy2(str(file_path), str(allure_results / attachment_name))

    @keyword("Capture And Attach Screenshot")
    def capture_and_attach_screenshot(self, name="Failure Screenshot"):
        """Capture page screenshot and attach it to the current Allure test."""
        try:
            selenium = BuiltIn().get_library_instance("SeleniumLibrary")
            path = selenium.capture_page_screenshot()
            self.attach_screenshot(path, name)
        except Exception:
            pass
