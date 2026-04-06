*** Settings ***
Documentation    Validate the login form
Library    SeleniumLibrary
Library    Collections
Library    ../CustomLibraries/Shop.py
Test Setup        Open the browser with the url
Test Teardown    UI Test Teardown
Resource        ../Pages/Generic.robot
Resource        ../Pages/LoginPage.robot
Resource        ../Pages/ShopPage.robot
Resource        ../Pages/CheckoutPage.robot
Resource        ../Pages/ConfirmationPage.robot

*** Variables ***
${Error_Message_Login}    css:.alert-danger
@{ListOfItems}            Blackberry    Nokia Edge    iphone X
${country_name}           Italy

*** Test Cases ***
Validate Unsuccessful Login
    [Tags]    smoke    regression
    LoginPage.Fill The Login Form    ${username}    ${invalid_password}
    LoginPage.wait until element is located
    LoginPage.verify error message is correct

Validate Cards display in the shopping page
    [Tags]    regression
    LoginPage.Fill The Login Form    ${valid_username}    ${valid_password}
    ShopPage.wait until element is located
    ShopPage.Verify card titles
    Add Items To Card And Checkout    @{ListOfItems}
    CheckoutPage.Verify items in the Checkout Page and proceed
    ConfirmationPage.Enter the Country and Select the Terms   ${country_name}
    ConfirmationPage.Purchase the product and Confirm the purchase

#    Select the Card    Blackberry

Select the Form and navigate to Child window
    [Tags]    new
    LoginPage.Fill the login details and Login Form



    



