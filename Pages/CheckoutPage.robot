*** Settings ***
Documentation    All the objects and keywords of the shop page
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem
Resource    Generic.robot

*** Variables ***
${Shop_page_load}         css:.nav-link


*** Keywords ***

wait until element is located
    Wait Until Element Passed Is Located     ${Shop_page_load}

Verify card titles
    @{expectedList} =    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    @{elements} =     Get Webelements   css=.card-title
    @{actualList} =    Create List

    FOR    ${element}    IN    @{elements}
        Log    ${element.text}
        Append To List   ${actualList}    ${element.text}
    END
    Lists Should Be Equal     ${expectedList}    ${actualList}

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