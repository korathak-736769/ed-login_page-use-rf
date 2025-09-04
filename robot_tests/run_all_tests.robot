*** Settings ***
Documentation   
Library          Process
Library    OperatingSystem
Suite Setup      Create Directory    ${OUTPUT DIR}

*** Variables ***
${OUTPUT DIR}    ${CURDIR}${/}test_results

*** Test Cases ***
Run All Tests and Generate Single Report
    Log    Starting all tests...    console=yes
    ${result}=    Run Process
    ...    robot
    ...    --name    "All Tests"
    ...    --outputdir    ${OUTPUT DIR}
    ...    --exclude    run_all_tests
    ...    .
    ...    shell=True
    ...    cwd=${CURDIR}
    Log    ${result.stdout}
    Log    All tests completed. Reports are in '${OUTPUT DIR}'.    console=yes
    Should Be Equal As Integers    ${result.rc}    0

*** Keywords ***
