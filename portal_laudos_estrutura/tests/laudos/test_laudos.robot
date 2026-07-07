*** Settings ***

Resource    ../../resources/keywords/login_laudos_keywords.robot
Resource    ../../resources/keywords/laudos_keywords.robot

Suite Setup       Abrir Sessao Logada Laudos
Suite Teardown    Close Browser


*** Test Cases ***

Validar Home Portal Laudos
    Validar Tela Laudos

Validar Pesquisa Laudo
    Pesquisar Laudo    OCREVUS
    Validar Tela Laudos

Validar Adicionar Novo Laudo
    Adicionar Novo Laudo