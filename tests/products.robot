*** Settings ***
Resource    ../resources/endpoints/products.robot
Resource    ../resources/shared/setup_teardowm.robot
Suite Setup    Criar uma sessao
Suite Teardown    Encerrar uma sessao

*** Test Cases ***
Teste 1 - Testar a busca de todos os produtos
    [Documentation]    teste para retornar todos os itens cadastrados
    Buscar todos os produtos cadastrados    expected_status=200
Teste 2 - Buscar um unico produto
    [Documentation]    teste para retornar um item cadastrado a partir do id
    Buscar somente um produto cadastrado    expected_status=200    id_product=1
Teste 3 - Buscar um produto a partir da busca do usuario
    [Documentation]    teste para retornar um item cadastrado a partir do nome do item
    Buscar um produto a partir de um valor    expected_status=200    search_item=phone
Teste 4 - Buscar as categorias dos produtos e retornar a busca
    [Documentation]    teste para retornar um item cadastrado a partir do nome do item
    Buscar as categorias dos produtos    expected_status=200
Teste 5 - Adicionar um novo produto
    [Documentation]    testando a adicao de um novo produto
    Adicionar um novo produto    expected_status=200    title_product=teste    description=test12234    category=phone

Teste 6- Editar um produto
    [Documentation]    teste para realizar a edição de um produto
    Atualizar um produto   expected_status=200     title=teste123

Teste 7 - Excluir um produto
    [Documentation]    teste para excluir um produto
    Deletar um produto    expected_status=200     id_product=1