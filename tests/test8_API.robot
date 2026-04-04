*** Settings ***
Documentation    Validate the login form
Library    SeleniumLibrary
Test Teardown    Close Browser
Library    Collections

*** Test Cases ***
Work with dictionary
    &{data}=    Create Dictionary    name=berk    framework=robot    lang=python
    log    ${data}
    Dictionary Should Contain Key   ${data}    name
    log    ${data}[name]
    ${l}=    Get From Dictionary    ${data}    lang
    Log    ${l}
