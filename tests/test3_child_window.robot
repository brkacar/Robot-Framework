*** Settings ***
Documentation    Validate the login form
Library    SeleniumLibrary
Library    String
Library    Collections
Test Setup        Open the browser with the url
Test Teardown    UI Test Teardown
Resource        ../Pages/Generic.robot

*** Variables ***
${Error_Message_Login}    css:.alert-danger


*** Test Cases ***
Validate Child window functionality
    [Tags]    smoke
    Select the child window link
    Verify the user switched to child window
    Grab the email in the child window
    Switch to ParenT window and enter the email

*** Keywords ***
Select the child window link
    Click Element    css:.blinkingText
    Sleep            5

Verify the user switched to child window
    Switch Window    NEW
    Element Text Should Be    css:h1    DOCUMENTS REQUEST

Grab the email in the child window
    ${text}=    Get Text    css:.red
    ${words}=    Split String    ${text}    at
    
    ${text_split}=    Get From List   ${words}    1
    Log    ${text_split}
    ${words_2}=    Split String    ${text_split}
    ${email}=    Get From List    ${words_2}    0
    Set Global Variable    ${email}    
    
Switch to ParenT window and enter the email
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text    id:username    ${email}
