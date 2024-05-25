*** Settings ***
Resource    ../main.robot
Resource    ../shared/setup_teardowm.robot
*** Variables ***


*** Keywords ***
Checa a Url principal
    [Arguments]    ${url}     ${expected-status}
    [Tags]    Teste basico da base url
    ${RESPONSE_GET}    GET On Session  alias=${alias}  url=${BASE_URL}    expected_status=${expected-status}
    IF  '${expected-status}' == 200
        ${message}  Set Variable    os endpoints se encontram disponiveis
        Log To Console    ${message}
    END
