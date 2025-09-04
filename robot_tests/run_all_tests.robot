*** Settings ***
Documentation    Master suite that runs all test cases
Resource         resource.robot
Library          Process

*** Test Cases ***
Run All Tests
    Log    Starting All Tests    console=yes
    
    # Run Login Tests
    Run Tests    login_tests.robot
    
    # Run SQL Injection Tests
    Run Tests    sql_injection_tests.robot
    
    # Run Registration Tests
    Run Tests    registration_tests.robot
    
    # Run Profile Tests
    Run Tests    profile_tests.robot
    
    Log    All Tests Completed    console=yes

*** Keywords ***
Run Tests
    [Arguments]    ${test_file}
    Log    Running tests from ${test_file}    console=yes
    Create Directory    ${CURDIR}/test_results
    ${result}=    Run Process    robot    -d    test_results    ${test_file}    shell=True    cwd=${CURDIR}
    Log    ${result.stdout}
    Log    Test result: ${result.rc}    console=yes
