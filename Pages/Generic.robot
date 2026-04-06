*** Settings ***
Documentation    A resource file with reusable keywords and variables.
Library          SeleniumLibrary    run_on_failure=Nothing
Library          Collections
Library          OperatingSystem
Library          Process
Library          ../CustomLibraries/AllureHelper.py

*** Variables ***
${user_name}          berk
${invalid_password}   12345
${valid_username}     rahulshettyacademy
${valid_password}     Learning@830$3mK2
${url}                https://rahulshettyacademy.com/loginpagePractise/
${browser}            chrome

*** Keywords ***
Open the browser with the url
    Open Browser               ${url}    ${browser}
    Maximize Browser Window
    Set Screenshot Directory   ${EXECDIR}${/}allure-results

Wait until element passed is located
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}

UI Test Teardown
    Run Keyword If Test Failed    Capture And Attach Screenshot    Failure Screenshot
    Run Keyword And Ignore Error  Close Browser
    Remove geckodriver logs

Remove geckodriver logs
    ${status}    ${files}=    Run Keyword And Ignore Error
    ...    List Files In Directory    .    pattern=*geckodriver*.log
    IF    '${status}' == 'PASS'
        FOR    ${file}    IN    @{files}
            Run Keyword And Ignore Error    Remove File    ${file}
        END
    END

Close Popup With Retry
    [Arguments]    ${okay_btn}
    FOR    ${i}    IN RANGE    3
        Run Keyword And Ignore Error    Click Element    ${okay_btn}
        ${closed}=    Run Keyword And Return Status
        ...    Wait Until Element Is Not Visible    ${okay_btn}    2s
        IF    ${closed}
            RETURN
        END
        Sleep    1s
    END
    Fail    Popup was still visible after 3 attempts
