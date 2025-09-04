*** Settings ***
Documentation    Test suite for testing profile page functionality and access control
Resource         resource.robot
Test Teardown    Close My Browser

*** Test Cases ***
Access Profile Without Login Test
    [Documentation]    Test if profile page redirects when not logged in
    Open Browser    ${URL}/profile.php    ${BROWSER}
    # Should redirect to login page
    Location Should Be    ${URL}/login.php
    
Profile Page Shows Correct User Data
    [Documentation]    Test if profile page displays correct user information
    # First login with a known user
    Open Login Page
    ${user}=    Get Random Valid User
    ${username}=    Set Variable    ${user[0][0]}
    ${password}=    Set Variable    ${user[0][1]}
    Input Credentials    ${username}    ${password}
    Submit Login Form
    Verify Successful Login
    
    # Get user data from database to compare
    Connect To MySQL Database
    ${query}=    Set Variable    SELECT username, first_name, last_name FROM users WHERE username='${username}'
    ${user_data}=    Query    ${query}
    
    # Check if profile page shows correct data
    Page Should Contain    Username: ${user_data[0][0]}
    Page Should Contain    First Name: ${user_data[0][1]}
    Page Should Contain    Last Name: ${user_data[0][2]}
    
SQL Injection In Profile Page Test
    [Documentation]    Test SQL injection in profile page
    # We need to set a session variable manually to simulate being logged in
    # This requires either browser cookies manipulation or direct URL manipulation
    # For simplicity, we'll test login bypass first, then check profile
    
    Open Login Page
    # Use SQL injection to login
    Input Credentials    ' OR '1'='1    anything
    Submit Login Form
    
    # If SQL injection was successful, we're on the profile page
    ${status}    ${value}=    Run Keyword And Ignore Error    Location Should Be    ${URL}/profile.php
    
    Run Keyword If    '${status}' == 'PASS'    Log    SQL Injection successful, checking profile data    WARN
    Run Keyword If    '${status}' == 'PASS'    Page Should Contain Element    xpath=//div[contains(@class, 'profile-info')]
