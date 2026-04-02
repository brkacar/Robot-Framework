*** Settings ***
Documentation    All the objects and keywords of the shop page
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem
Resource    Generic.robot

*** Variables ***
${Shop_page_load}         css:.nav-link
${country_location}    //a[text()='Italy']

*** Keywords ***

Enter the Country and Select the Terms
    [Arguments]    ${country_name}
    Input Text    country    ${country_name}
    Sleep    2
    Wait Until Element Passed Is Located    //a[text()='${country_name}']
    Click Element    //a[text()='${country_name}']
    Click Element    css:label[for='checkbox2']


Purchase the product and Confirm the purchase
    Click Button    css:.btn-success
    Page Should Contain    Success!



