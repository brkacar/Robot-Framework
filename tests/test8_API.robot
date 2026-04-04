*** Settings ***
Library    Collections
Library    RequestsLibrary

*** Variables ***
${base_url}    https://rahulshettyacademy.com/
${id}
${book_name}    RobotFramework0

*** Test Cases ***
Work with dictionary
    &{data}=    Create Dictionary    name=berk    framework=robot    lang=python
    log    ${data}
    Dictionary Should Contain Key   ${data}    name
    log    ${data}[name]
    ${l}=    Get From Dictionary    ${data}    lang
    log    ${l}

Add Book into Library Database
    [Tags]    API
    &{req_body}=    Create Dictionary    name=${book_name}    isbn=499    aisle=13913    author=BerkAcar
    ${response}=    POST      ${base_url}/Library/Addbook.php    json=${req_body}    expected_status=200
    log    ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    ID
    ${id}=    Get From Dictionary    ${response.json()}    ID
    Set Global Variable   ${id}  
    log    ${id}
    Should Be Equal As Strings    successfully added    ${response.json()}[Msg]
    Status Should Be    200   ${response}

Get the book details that were added
    [Tags]    API
    ${get_response}=    GET    ${base_url}/Library/GetBook.php    params=ID=${id}     expected_status=200
    Log    ${get_response.json()}
    Should Be Equal As Strings    ${book_name}    ${get_response.json()}[0][book_name]

Delete the book from db
    [Tags]    API
    &{delete_rec}=    Create Dictionary    ID=${id}
    ${delete_response}=    POST    ${base_url}/Library/DeleteBook.php    json=&{delete_rec}    expected_status=200
    log    ${delete_response.json()}
    Should Be Equal As Strings   book is successfully deleted    ${delete_response.json()}[msg]
    
    