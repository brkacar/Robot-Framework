*** Settings ***
Documentation    A resource file with resusable keywords and variables.
...
...              The system specific keyword created here form the domain specific language.
...              They utilize the imported SeleniumLibrary.
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem
Library    Process


*** Variables ***
${user_name}           berk
${invalid_password}    12345
${valid_username}      rahulshettyacademy
${valid_password}      Learning@830$3mK2
${url}                 https://rahulshettyacademy.com/loginpagePractise/
${browser}             chrome


*** Keywords ***

#Open the browser with the Mortgage payment url
##    Create Webdriver    Chrome
##    Go to    ${url}
#    Open Browser    ${url}    ${browser}    options=add_experimental_option("detach",True)

Open the browser with the url
    Open Browser    ${url}    ${browser}

wait until element passed is located
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}

Remove geckodriver logs
    @{files} =    List Files In Directory    C:/Users/berka/PycharmProjects/RobotFramework    *geckodriver*.log
    FOR    ${file}    IN    @{files}
        Run Keyword And Ignore Error    Remove File    ${file}
    END
