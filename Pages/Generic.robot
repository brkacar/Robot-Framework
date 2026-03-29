*** Settings ***
Documentation    A resource file with resusable keywords and variables.
...
...              The system specific keyword created here form the domain specific language.
...              They utilize the imported SeleniumLibrary.
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem


*** Variables ***
${user_name}           berk
${invalid_password}    12345
${valid_username}      rahulshettyacademy
${valid_password}      Learning@830$3mK2
${url}                 https://rahulshettyacademy.com/loginpagePractise/


*** Keywords ***

Open the browser with the url
#    Create Webdriver    Chrome
#    Go to    ${url}
    Open Browser    ${url}    Chrome    options=add_experimental_option("detach",True)

wait until element passed is located
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}