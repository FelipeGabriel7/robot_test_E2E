*** Settings ***
Resource    ../main.robot

*** Keywords ***
Criar uma sessao
    [Documentation]   Cria uma sessao inicial para se conectar a api
    Create Session   ${alias}    ${BASE_URL}

Encerrar uma sessao
    [Documentation]   Encerrando uma sessao da conexao com a api apos o fim dos testes
    Sleep    3s
    Delete All Sessions    
