*** Settings ***
Documentation    All the objects and keywords of the shop page
Library    SeleniumLibrary

*** Variables ***
${Shop_page_load}         css:.nav-link


*** Keywords ***

Verify items in the Checkout Page and proceed
    Click Element    css:.btn-success