*** Settings ***
Documentation    Test suite for testing SQL injection vulnerabilities
Resource         resource.robot
Test Setup       Open Login Page
Test Teardown    Close My Browser

*** Variables ***
@{SQL_INJECTION_PAYLOADS}    
...    ' OR '1'='1
...    ' OR '1'='1' --
...    " OR "1"="1
...    " OR "1"="1" --
...    admin' --
...    ' OR '1'='1' LIMIT 1;--
...    '; DROP TABLE users; --

*** Test Cases ***
SQL Injection Login Bypass Test
    [Documentation]    Test if we can bypass login using SQL Injection
    [Template]    Test SQL Injection Login
    # Using the payloads defined in variables
    ${SQL_INJECTION_PAYLOADS}[0]    any
    ${SQL_INJECTION_PAYLOADS}[1]    any
    ${SQL_INJECTION_PAYLOADS}[2]    any
    ${SQL_INJECTION_PAYLOADS}[3]    any
    
SQL Injection Login As Specific User
    [Documentation]    Test if we can login as a specific user using SQL Injection
    Input Credentials    admin' --    anything
    Submit Login Form
    # If vulnerable, we should be logged in as admin
    Run Keyword And Ignore Error    Verify Successful Login
    # Check if username shown on profile page is 'admin'
    Run Keyword And Ignore Error    Page Should Contain    Username: admin
    
SQL Injection Test with Multiple Statements
    [Documentation]    Test using SQL Injection with multiple statements (should not work with MySQLi)
    Input Credentials    ${SQL_INJECTION_PAYLOADS}[6]    anything
    Submit Login Form
    Verify Failed Login

*** Keywords ***
Test SQL Injection Login
    [Arguments]    ${injection_payload}    ${password}
    Input Credentials    ${injection_payload}    ${password}
    Submit Login Form
    ${status}    ${value}=    Run Keyword And Ignore Error    Verify Successful Login
    # Log result for reporting
    Run Keyword If    '${status}' == 'PASS'    Log    SQL Injection succeeded with payload: ${injection_payload}    WARN
    Run Keyword If    '${status}' == 'FAIL'    Log    SQL Injection failed with payload: ${injection_payload}    INFO
