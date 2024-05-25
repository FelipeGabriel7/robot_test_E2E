*** Settings ***
Resource    ../resources/shared/setup_teardowm.robot
Resource    ../resources/endpoints/base.robot
Resource    ../resources/endpoints/login.robot
Suite Setup    Criar uma sessao
Suite Teardown    Encerrar uma sessao

*** Test Cases ***
Teste 1 - Checar a url principal do site
    [Documentation]        teste para verificar se a url se encontra disponível
    Checa a Url principal  ${BASE_URL}  expected-status=200

Teste 2 - Autenticar e obter o token
    [Documentation]     teste onde sera feito a criacao do usuário , autenticação e autorização do mesmo
    ${token_user}     Criar um usuario e obter o token do mesmo, apos isso autenticar o usuario    expected_status=200
    Autenticar o usuario a partir do token obtido    ${token_user}    expected_status=200
    Recarregar o token do usuario    ${token_user}    expected_status=200