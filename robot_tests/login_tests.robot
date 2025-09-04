*** Settings ***
Documentation    Test suite for testing login functionality of the website
Resource         resource.robot
Test Setup       Open Login Page
Test Teardown    Close My Browser

*** Test Cases ***
Valid Login Test
    ${user}=    Get Random Valid User
    ${username}=    Set Variable    ${user[0][0]}
    ${password}=    Set Variable    ${user[0][1]}
    Input Credentials    ${username}    ${password}
    Submit Login Form
    Verify Successful Login

Invalid Login Test - Wrong Password
    ${user}=    Get Random Valid User
    ${username}=    Set Variable    ${user[0][0]}
    ${password}=    Set Variable    invalid_password
    Input Credentials    ${username}    ${password}
    Submit Login Form
    Verify Failed Login

Invalid Login Test - Non-existent User
    ${invalid_user}=    Create Invalid User Data
    Input Credentials    ${invalid_user[0]}    ${invalid_user[1]}
    Submit Login Form
    Verify Failed Login

Empty Credentials Test
    Input Credentials    ${EMPTY}    ${EMPTY}
    Submit Login Form
    Page Should Not Contain    User Profile

Login And Logout Test
    ${user}=    Get Random Valid User
    ${username}=    Set Variable    ${user[0][0]}
    ${password}=    Set Variable    ${user[0][1]}
    Input Credentials    ${username}    ${password}
    Submit Login Form
    Verify Successful Login
    Logout
    Title Should Be    Login
