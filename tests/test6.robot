*** Settings ***
Documentation    Validate the login form
Library    SeleniumLibrary
Library    Collections
Library    ../customLibraries/Shop.py
Test Setup        Open the browser with the url
Test Teardown    Close Browser
Resource        resource.robot

*** Variables ***
${Error_Message_Login}    css:.alert-danger
${Shop_page_load}         css:.nav-link


*** Test Cases ***
#Validate Unsuccessful Login
#    Fill The Login Form    ${username}    ${invalid_password}
#    wait until element is located    ${Error_Message_Login}

 
Validate Cards display in the shopping page
    Fill The Login Form    ${valid_username}    ${valid_password}
    wait until element is located    ${Shop_page_load}
    Verify card titles
    Hello World
    Select the Card    Blackberry

#Select the Form and navigate to Child window
#    Fill the login details and Login Form    ${valid_username}    ${valid_password}

*** Keywords ***

Fill the login form
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Click Button    signInBtn

wait until element is located
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}
    
verify error message is correct
    ${message}=    Get Text    ${Error_Message_Login}
    Should Be Equal As Strings    ${message}    Incorrect username/password.
    Element Text Should Be    ${Error_Message_Login}     Incorrect username/password.

Verify card titles
    @{expectedList} =    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    @{elements} =     Get Webelements   css=.card-title
    @{actualList} =    Create List
    
    FOR    ${element}    IN    @{elements}
        Log    ${element.text}
        Append To List   ${actualList}    ${element.text}
    END
    Lists Should Be Equal     ${expectedList}    ${actualList}

#Select the Card
#    [Arguments]    ${cardName}
#    @{elements} =     Get Webelements   css:.card-title
#    ${i}=    Set Variable    1
#    FOR    ${element}    IN    @{elements}
#        Exit For Loop If     '${cardName}'=='${element.text}'
#        ${i}=    Evaluate    ${i} + 1
#    END
#    Click Button    xpath=(//*[ @class='card-footer'])[${i}]/button

Select the Card
    [Arguments]    ${cardName}
    Click Button    xpath=//*[.='${cardName}']/../../..//button

Fill the login details and Login Form
    [Arguments]    ${username}    ${password}
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}
    Click Element    css:input[value='user']
    Wait Until Element Is Visible    id:okayBtn
    Click Button    id:okayBtn
    Wait Until Element Is Not Visible    id:okayBtn
    Select From List By Value    css:select.form-control    teach
    Select Checkbox    terms
    Checkbox Should Be Selected    terms