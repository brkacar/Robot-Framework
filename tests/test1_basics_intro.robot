*** Settings ***
Documentation    Validate the login form
Library    SeleniumLibrary
Test Teardown    Close Browser

*** Variables ***
${Error_Message_Login}    css=.alert-danger
${browser}                chrome
${url}                    https://rahulshettyacademy.com/loginpagePractise/

*** Test Cases ***
Validate Unsuccessful Login
    Open the browser with the first url
    Fill the login form
    wait until it displays error message
    verify error message is correct

*** Keywords ***
Open the browser with the first url
    Open Browser    ${url}    ${browser}

Fill the login form
    Input Text    id=username    bacar
    Input Password    id=password    12345
    Click Button    signInBtn


wait until it displays error message
    Wait Until Element Is Visible    ${Error_Message_Login}
    
verify error message is correct
    ${message}=    Get Text    ${Error_Message_Login}
    Should Be Equal As Strings    ${message}    Incorrect username/password.
    Element Text Should Be    ${Error_Message_Login}     Incorrect username/password.
