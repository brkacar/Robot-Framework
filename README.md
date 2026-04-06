# Robot Framework Test Suite

A comprehensive Robot Framework automation project covering UI (web) testing, API testing, the Page Object Model, data-driven testing, parallel execution with pabot, and custom Python libraries. Built with SeleniumLibrary and RequestsLibrary targeting real-world web applications.
## Features

- **UI automation** with SeleniumLibrary across multiple browsers.
- **API testing** with RequestsLibrary (test8).
- **Page Object Model (POM)** pattern with dedicated keyword files per page.
- **Data-driven testing** using Robot Framework templates and CSV files.
- **Custom Python libraries** in `CustomLibraries/` for reusable logic.
- **Parallel execution** with `pabot` (results stored in `pabot_results/`).
- **Tag-based filtering** to run specific test groups from the CLI.
- **Child window handling**, functional flows, and custom keyword composition.
- Helper runner script via `CustomLibraries/Shop.py`.
- **GitHub Actions CI** for automated test execution on every push and pull request.
- **Allure report** published to GitHub Pages with trend charts and step-level details.
- **Screenshots on failure** automatically captured and attached to the report.

## Tech stack

| Tool | Purpose |
|---|---|
| Robot Framework | Test framework and execution engine |
| SeleniumLibrary | Browser-based UI automation |
| RequestsLibrary | HTTP API testing |
| pabot | Parallel Robot Framework execution |
| Python 3 | Custom libraries and runner script |
| PyCharm (.idea) | IDE configuration |

## Project structure

```text
Robot-Framework/
  Pages/                        # Page Object keyword files
    CheckoutPage.robot
    ConfirmationPage.robot
    Generic.robot               # Shared/generic keywords (incl. API)
    LoginPage.robot
    ShopPage.robot
  CustomLibraries/              # Custom Python keyword libraries
  tests/
    resources/                  # Shared variables and resource files
    pabot_results/              # Parallel run results
    test1_basics_intro.robot
    test2_functional_automation.robot
    test3_child_window.robot
    test4_run_test_with_multiple_datq.robot
    test5_Data_Driven_csv.robot
    test6_Custom_Keywords.robot
    test7_PageObject.robot
    test8_API.robot
  pabot_results/                # Top-level pabot results

  README.md
```

## Test suite overview

| File | Description |
|---|---|
| `test1_basics_intro.robot` | Robot Framework basics: keywords, variables, setup/teardown |
| `test2_functional_automation.robot` | End-to-end functional UI flows |
| `test3_child_window.robot` | Handling browser child/popup windows |
| `test4_run_test_with_multiple_datq.robot` | Data-driven tests using templates with multiple datasets |
| `test5_Data_Driven_csv.robot` | CSV-file-driven data testing |
| `test6_Custom_Keywords.robot` | Composing and reusing custom keyword definitions |
| `test7_PageObject.robot` | Page Object Model pattern with `Pages/` keyword files |
| `test8_API.robot` | API testing with RequestsLibrary |

## Getting started

### Prerequisites

- Python >= 3.8
- pip
- Google Chrome (or Firefox) + matching WebDriver

### Install dependencies

```bash
git clone https://github.com/brkacar/Robot-Framework.git
cd Robot-Framework
pip install robotframework
pip install robotframework-seleniumlibrary
pip install robotframework-requests
pip install robotframework-pabot
```

## Running tests

### Run the full test suite

```bash
robot tests/
```

### Run a single test file

```bash
robot tests/test1_basics_intro.robot
```

### Run tests by tag

```bash
robot --include <tag_name> tests/
```

### Run tests in parallel with pabot

```bash
pabot --processes 4 tests/
```

Parallel results are collected in `pabot_results/`.

### Run with a specific browser

```bash
robot --variable BROWSER:firefox tests/
```

## Reports

After each run, Robot Framework generates reports in the working directory:

- `log.html` — Detailed step-by-step execution log.
- `report.html` — High-level summary report.
- `output.xml` — Machine-readable results (for CI integration).

Open them in any browser:

```bash
start report.html    # Windows
open report.html     # macOS/Linux
```

## Page Object Model

The `Pages/` folder contains keyword resource files, one per page/component:

- `LoginPage.robot` — Login page actions and validations.
- `ShopPage.robot` — Product listing and add-to-cart interactions.
- `CheckoutPage.robot` — Checkout form and submission.
- `ConfirmationPage.robot` — Order confirmation validations.
- `Generic.robot` — Shared browser setup, teardown, and common keywords.

Test files import these pages directly, keeping test logic clean and maintainable.

## Custom libraries

The `CustomLibraries/` folder contains Python files that extend Robot Framework with custom keywords. These can be imported in any `.robot` file:

```robot
Library    ../CustomLibraries/MyLibrary.py
```

## Use cases

- Learn and demonstrate Robot Framework fundamentals and advanced patterns.
- Practice UI automation with SeleniumLibrary using POM and data-driven approaches.
- Explore API test design with RequestsLibrary.
- Use as a reference for parallel test execution with pabot in CI pipelines.

## GitHub Actions CI

Tests run automatically on every push and pull request via GitHub Actions. The workflow installs all dependencies, executes the full Robot Framework suite, captures screenshots for any failed UI tests, and uploads the standard Robot reports (`log.html`, `report.html`, `output.xml`) as run artifacts.

If some tests fail but the pipeline itself completes successfully, the workflow still finishes and produces all artifacts, so failures can be reviewed without rerunning the suite locally.

Once the run completes, all Robot Framework reports (`log.html`, `report.html`, `output.xml`) are available to download as a **ZIP file** from the **Artifacts** section at the bottom of the Actions run summary page.

## Allure report

An Allure report is generated in CI on every run and published to **GitHub Pages**. It provides a visual, trend-aware view of test results across runs, making it easy to track pass/fail history and inspect individual test steps directly from the browser.

The latest report is always available at:

👉 https://brkacar.github.io/Robot-Framework

## Screenshots for failed tests

Failed UI tests automatically capture a browser screenshot at teardown. Screenshots are attached to the Allure report and are also available as workflow artifacts in the Actions run, giving immediate visual context for each failure without having to reproduce it locally.
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/dc109d3e-a013-4870-8ade-3f7844cfe72f" />

