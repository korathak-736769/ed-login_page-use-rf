*** Settings ***
Documentation    Test suite for testing registration functionality
Resource         resource.robot
Test Setup       Open Registration Page
Test Teardown    Close My Browser

*** Keywords ***
Open Registration Page
    Open Browser    ${URL}/register.php    ${BROWSER}
    Title Should Be    Register
    
Generate Random User Data
    ${random_string}=    Generate Random String    8    [LETTERS]
    ${username}=    Set Variable    user_${random_string}
    ${password}=    Set Variable    pass_${random_string}
    ${first_name}=    Set Variable    FirstName_${random_string}
    ${last_name}=    Set Variable    LastName_${random_string}
    @{user_data}=    Create List    ${username}    ${password}    ${first_name}    ${last_name}
    [Return]    ${user_data}
    
Input Registration Form
    [Arguments]    ${username}    ${password}    ${first_name}    ${last_name}
    Input Text    id=username    ${username}
    Input Password    id=password    ${password}
    Input Text    id=first_name    ${first_name}
    Input Text    id=last_name    ${last_name}
    
Submit Registration Form
    Click Button    xpath=//button[@type='submit']
    
Verify Successful Registration
    Page Should Contain    Registration successful
    
Verify User Exists In Database
    [Arguments]    ${username}
    Connect To MySQL Database
    ${query}=    Set Variable    SELECT COUNT(*) FROM users WHERE username='${username}'
    ${result}=    Query    ${query}
    Should Be Equal As Integers    ${result[0][0]}    1
    
Delete Test User
    [Arguments]    ${username}
    Connect To MySQL Database
    Execute Sql String    DELETE FROM users WHERE username='${username}'

*** Test Cases ***
Valid Registration Test
    ${user_data}=    Generate Random User Data
    Input Registration Form    ${user_data}[0]    ${user_data}[1]    ${user_data}[2]    ${user_data}[3]
    Submit Registration Form
    Verify Successful Registration
    Verify User Exists In Database    ${user_data}[0]
    # Clean up after test
    Delete Test User    ${user_data}[0]
    
Registration With Existing Username
    # First, get an existing user
    Connect To MySQL Database
    ${existing_user}=    Query    SELECT username FROM users LIMIT 1
    ${existing_username}=    Set Variable    ${existing_user[0][0]}
    
    # Try to register with the same username
    ${user_data}=    Generate Random User Data
    Input Registration Form    ${existing_username}    ${user_data}[1]    ${user_data}[2]    ${user_data}[3]
    Submit Registration Form
    Page Should Contain    Username already exists
    
Empty Fields Registration Test
    Input Registration Form    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Submit Registration Form
    # HTML required validation should prevent form submission
    # Form should still be visible
    Page Should Contain Element    xpath=//form
