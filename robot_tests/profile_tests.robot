*** Settings ***
Documentation    
Resource         resource.robot
Test Teardown    Close My Browser

*** Test Cases ***
Access Profile Without Login Test
    [Documentation]  
    Open Browser    ${URL}/profile.php    ${BROWSER}
    Location Should Be    ${URL}/login.php
    
Profile Page Shows Correct User Data
    [Documentation]    Test if profile page displays correct user information
    Open Login Page
    ${user}=    Get Random Valid User
    ${username}=    Set Variable    ${user[0][0]}
    ${password}=    Set Variable    ${user[0][1]}
    Input Credentials    ${username}    ${password}
    Submit Login Form
    Verify Successful Login
    
    Connect To MySQL Database
    ${query}=    Set Variable    SELECT username, first_name, last_name FROM users WHERE username='${username}'
    ${user_data}=    Query    ${query}
    
    Page Should Contain    Username: ${user_data[0][0]}
    Page Should Contain    First Name: ${user_data[0][1]}
    Page Should Contain    Last Name: ${user_data[0][2]}
    
SQL Injection In Profile Page Test
    [Documentation]    Test SQL injection in profile page
    Open Login Page
    Input Credentials    ' OR '1'='1    anything
    Submit Login Form
    
    ${status}    ${value}=    Run Keyword And Ignore Error    Location Should Be    ${URL}/profile.php
    
    Run Keyword If    '${status}' == 'PASS'    Log    SQL Injection successful, checking profile data    WARN
    Run Keyword If    '${status}' == 'PASS'    Page Should Contain Element    xpath=//div[contains(@class, 'profile-info')]

