*** Settings ***
Resource    ../main.robot
Resource    ../shared/setup_teardowm.robot

Library    Collections

*** Variables ***



*** Keywords ***
Buscar todos os produtos cadastrados
    [Arguments]    ${expected_status}

    ${RESPONSE_GET}    GET On Session   alias=${alias}    url=${BASE_URL}products    expected_status=${expected_status}
    ${status_code}     Set Variable     ${RESPONSE_GET.status_code}
    ${RESPONSE_JSON}    Set Variable    ${RESPONSE_GET.json()}

    IF    '${status_code}' == '200'
        Log To Console    Produtos buscados com sucesso
    ELSE
        Log To Console    Ocorreu um erro ao buscar os produtos
    END

Buscar somente um produto cadastrado
    [Arguments]    ${expected_status}    ${id_product}

    ${RESPONSE_GET}    GET On Session   alias=${alias}    url=${BASE_URL}products/${id_product}    expected_status=${expected_status}
    ${status_code}     Set Variable     ${RESPONSE_GET.status_code}
    ${RESPONSE_JSON}    Set Variable    ${RESPONSE_GET.json()}

    IF    '${status_code}' == '200'
        Log To Console    Produtos buscados com sucesso
    ELSE
        Log To Console    Ocorreu um erro ao buscar os produtos
    END

Buscar um produto a partir de um valor
    [Arguments]    ${expected_status}    ${search_item}

    ${RESPONSE_GET}    GET On Session   alias=${alias}    url=${BASE_URL}products/search?q=${search_item}    expected_status=${expected_status}
    ${status_code}     Set Variable     ${RESPONSE_GET.status_code}
    ${RESPONSE_JSON}    Set Variable    ${RESPONSE_GET.json()}

    IF    '${status_code}' == '200'
        Log To Console    Produtos buscados com sucesso
    ELSE
        Log To Console    Ocorreu um erro ao buscar os produtos
    END

Buscar as categorias dos produtos
    [Arguments]    ${expected_status}

    ${RESPONSE_GET}    GET On Session   alias=${alias}    url=${BASE_URL}products/categories    expected_status=${expected_status}
    ${status_code}     Set Variable     ${RESPONSE_GET.status_code}
    ${RESPONSE_JSON}    Set Variable    ${RESPONSE_GET.json()}

    IF    '${status_code}' == '200'
        Log To Console    Produtos buscados com sucesso
    ELSE
        Log To Console    Ocorreu um erro ao buscar os produtos
    END

Adicionar um novo produto
    [Arguments]    ${expected_status}    ${title_product}    ${description}   ${category}
    ${headers}    Create Dictionary      Content-Type=application/json
    ${RESPONSE_POST}    POST On Session    alias=${alias}    headers=${headers}    url=${BASE_URL}products/add
    ...    data={"title": "${title_product}", "description": "${description}","category": "${category}"}
    
    ${status_code}    Set Variable    ${RESPONSE_POST.status_code}
    ${RESPONSE_JSON}    Set Variable    ${RESPONSE_POST.json()}
    ${title_response}    Set Variable    ${RESPONSE_JSON['title']}
    ${desc_response}     Set Variable    ${RESPONSE_JSON['description']}
    ${category_response}  Set Variable    ${RESPONSE_JSON['category']}
    ${id_response}        Set Variable    ${RESPONSE_JSON['id']}

    Should Be Equal As Strings   ${title_response}    ${title_product}
    Should Be Equal As Strings    ${desc_response}     ${description}
    Should Be Equal As Strings    ${category_response}    ${category_response}

    IF  '${status_code}' == '200'
        Log To Console    Produto adicionado com sucesso
    ELSE 
        Log To Console   Teste
    END

Atualizar um produto
    [Arguments]    ${expected_status}    ${title}

    Log To Console    produto

    ${headers}    Create Dictionary      Content-Type=application/json
    ${RESPONSE_POST}    PUT On Session    alias=${alias}    headers=${headers}    url=${BASE_URL}products/1
    ...    data={"title": "${title}"}    expected_status=${expected_status}
    
    ${status_code}    Set Variable    ${RESPONSE_POST.status_code}
    ${headers}        Set Variable    ${RESPONSE_POST.headers}
    ${title_response}    Set Variable    ${RESPONSE_POST.json()['title']}
    ${desc_response}     Set Variable    ${RESPONSE_POST.json()['description']}
    ${category_response}  Set Variable    ${RESPONSE_POST.json()['category']}

    Should Not Be Empty    ${headers}
    Should Be Equal As Strings    ${title_response}    ${title}

    IF  '${status_code}' == 200
            Log To Console    usuario editado com sucesso
    ELSE
            Log To Console    ocorreu um erro ao editar o usuario
    END

Deletar um produto
    [Arguments]    ${expected_status}    ${id_product}

    ${RESPONSE_DELETE}    DELETE On Session    alias=${alias}    url=${BASE_URL}products/${id_product}  expected_status=${expected_status} 
    ${status_code}    Set Variable    ${RESPONSE_DELETE.status_code}
    ${DELETE_JSON}    Set Variable    ${RESPONSE_DELETE.json()}

    IF  '${status_code}' == '200'
        Log To Console    produto deletado com sucesso
    ELSE
        Log To Console    Ocorreu um erro ao excluir o produto
    END

