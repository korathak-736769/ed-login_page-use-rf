*** Settings ***
Library    SeleniumLibrary
Library    DatabaseLibrary
Library    OperatingSystem
Library    String

*** Variables ***
${BROWSER}        chrome
${URL}            http://localhost/ed-login_page-use-rf
${DB_HOST}        localhost
${DB_NAME}        testdb
${DB_USER}        root
${DB_PASS}        ${EMPTY}

*** Keywords ***
Connect To MySQL Database
    Connect To Database    pymysql    ${DB_NAME}    ${DB_USER}    ${DB_PASS}    ${DB_HOST}
    
Get User Credentials
    [Arguments]    ${username}
    Connect To MySQL Database
    ${query}=    Set Variable    SELECT username, password FROM users WHERE username='${username}'
    ${result}=    Query    ${query}
    [Return]    ${result}
    
Get Random Valid User
    Connect To MySQL Database
    ${query}=    Set Variable    SELECT username, password FROM users ORDER BY RAND() LIMIT 1
    ${result}=    Query    ${query}
    [Return]    ${result}
    
Create Invalid User Data
    ${random_string}=    Generate Random String    8    [LETTERS]
    ${invalid_user}=    Set Variable    ${random_string}
    ${invalid_pass}=    Set Variable    ${random_string}_pass
    @{credentials}=    Create List    ${invalid_user}    ${invalid_pass}
    [Return]    ${credentials}

Open Login Page
    Open Browser    ${URL}/login.php    ${BROWSER}
    Title Should Be    Login
    
Input Credentials
    [Arguments]    ${username}    ${password}
    Input Text    id=username    ${username}
    Input Password    id=password    ${password}
    
Submit Login Form
    Click Button    xpath=//button[@type='submit']
    
Verify Successful Login
    Location Should Be    ${URL}/profile.php
    Page Should Contain    User Profile
    
Verify Failed Login
    Page Should Contain    Invalid username or password
    
Logout
    Click Button    xpath=//button[contains(@class, 'logout-btn')]
    Location Should Be    ${URL}/login.php
    
Close My Browser
    Close All Browsers
