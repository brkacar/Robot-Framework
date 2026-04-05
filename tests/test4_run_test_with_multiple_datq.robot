*** Settings ***
Documentation    Validate the login form
Library    SeleniumLibrary
Test Teardown    Close Browser
Test Template    Validate Unsuccessful Login

*** Variables ***
${Error_Message_Login}    css=.alert-danger
${browser}                chrome
${url}                    https://rahulshettyacademy.com/loginpagePractise/

*** Test Cases ***    username        password
Invalid username      dasd            learning
Invalid password      rahulshetty     palda
special characters    @#$             learning

*** Keywords ***
Validate Unsuccessful Login
    [Arguments]    ${username}    ${password}
    Open the browser with the first url
    Fill the login form    ${username}    ${password}
    wait until it displays error message
    verify error message is correct


Open the browser with the first url
    Open Browser    ${url}    ${browser}

Fill the login form
    [Arguments]    ${username}    ${password}
    Input Text     id:username    ${username}
    Input Password    id:password    ${password}
    Click Button    signInBtn

wait until it displays error message
    Wait Until Element Is Visible    ${Error_Message_Login}
    
verify error message is correct
    ${message}=    Get Text    ${Error_Message_Login}
    Should Be Equal As Strings    ${message}    Incorrect username/password.
    Element Text Should Be    ${Error_Message_Login}     Incorrect username/password.
