*** Settings ***
Documentation    Validate the login form
Library    SeleniumLibrary
Library    Collections
Library    ../customLibraries/Shop.py
Test Setup        Open the browser with the url
Test Teardown    Close Browser
Resource        ../Pages/Generic.robot
Resource        ../Pages/LoginPage.robot
Resource        ../Pages/ShopPage.robot


*** Variables ***
${Error_Message_Login}    css:.alert-danger
@{ListOfItems}            Blackberry    Nokia Edge    iphone X


*** Test Cases ***
Validate Unsuccessful Login
    LoginPage.Fill The Login Form    ${username}    ${invalid_password}
    LoginPage.wait until element is located
    LoginPage.verify error message is correct

Validate Cards display in the shopping page
    LoginPage.Fill The Login Form    ${valid_username}    ${valid_password}
    ShopPage.wait until element is located
    ShopPage.Verify card titles
    Add Items To Card And Checkout    @{ListOfItems}

#    Select the Card    Blackberry

Select the Form and navigate to Child window
    LoginPage.Fill the login details and Login Form



    



