*** Settings ***
Resource    ../main.robot
Resource    ../shared/setup_teardowm.robot
Library      Collections

*** Variables *** 
${password}        emilyspass
${expires_in}       30
${username}        emilys

*** Keywords ***
Criar um usuario e obter o token do mesmo, apos isso autenticar o usuario
    [Arguments]        ${expected_status}
    ${headers}    Create Dictionary    Content-Type=application/json
    ${RESPONSE_POST}    POST On Session    alias=${alias}    headers=${headers}     
    ...    url=${BASE_URL}auth/login    
    ...    data={"username": "${username}", "password": "${password}", "expireInMins":"${expires_in}"} 
    
    ${status_code}    Set Variable    ${RESPONSE_POST.status_code}
   
    ${token_user}        Set Variable    ${RESPONSE_POST.json()['token']}
    ${status_code}       Set Variable    ${RESPONSE_POST.status_code}

    IF  '${status_code}' == '200'
        Log To Console    Usuario criado e obtido seu token com sucesso
         ${return_info_user}    Set Variable    ${RESPONSE_POST.json()}
         Log To Console        'Usuario: ${return_info_user['username']}'
    ELSE
        Log To Console    Ocorreu um erro ao buscar o usuario
    END    

    RETURN     ${token_user}

Autenticar o usuario a partir do token obtido
    [Arguments]    ${token}    ${expected_status}
    ${headers}    Create Dictionary    Content-Type=application/json    Authorization=${token}
    ${RESPONSE_POST}    GET On Session     alias=${alias}    headers=${headers}
    ...    url=${BASE_URL}auth/me      expected_status=${expected_status}
    ${status_code}       Set Variable    ${RESPONSE_POST.status_code}

    IF  '${status_code}' == '200'
        Log To Console    Usuario Autenticado com sucesso
         ${return_info_user}    Set Variable    ${RESPONSE_POST.json()}
         Log To Console        'Usuario: ${return_info_user['username']}'
    ELSE
        Log To Console    Ocorreu um erro ao autenticar o usuario
    END    
    
    Log To Console    Usuario autenticado com sucesso

Recarregar o token do usuario
    [Arguments]    ${token}    ${expected_status}

    ${headers}     Create Dictionary      Content-Type=application/json     Authorization=${token}
    ${RESPONSE_POST}    POST On Session    alias=${alias}    headers=${headers}
    ...    url=${BASE_URL}auth/refresh
    ...    expected_status=${expected_status}
    
    Log To Console    Token Recarregado com sucesso