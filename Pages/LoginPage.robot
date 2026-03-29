*** Settings ***
Documentation    All the objects and keywords of the login page
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem
Resource    Generic.robot

*** Variables ***
${Error_Message_Login}    css:.alert-danger

*** Keywords ***

Fill the login form
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Click Button    signInBtn

wait until element is located
    Wait Until Element Passed Is Located    ${Error_Message_Login}

verify error message is correct
    ${message}=    Get Text    ${Error_Message_Login}
    Should Be Equal As Strings    ${message}    Incorrect username/password.
    Element Text Should Be    ${Error_Message_Login}     Incorrect username/password.

Fill the login details and Login Form
    Input Text        id:username    rahulshettyacademy
    Input Password    id:password    Learning@830$3mK2
    Click Element     css:input[value='user']
    Wait Until Element Is Visible    id:okayBtn
    Click Button      id:okayBtn
    Wait Until Element Is Not Visible    id:okayBtn
    Select From List By Value    css:select.form-control    teach
    Select Checkbox    terms
    Checkbox Should Be Selected    terms