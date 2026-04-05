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

### Use the Python runner script

```bash
python main.py
```

## Reports

After each run, Robot Framework generates reports in the working directory:

- `log.html` — Detailed step-by-step execution log.
- `report.html` — High-level summary report.
- `output.xml` — Machine-readable results (for CI integration).

Open them in any browser:

```bash
start report.html   # Windows
open report.html    # macOS/Linux
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
