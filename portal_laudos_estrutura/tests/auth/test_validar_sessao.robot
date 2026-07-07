*** Settings ***
Resource    ../../resources/keywords/login_laudos_keywords.robot
Library     Browser

Suite Setup       Abrir Sessao Logada Laudos
Suite Teardown    Close Browser

*** Test Cases ***

Validar Sessao Salva

    ${url}=    Get Url
    Log To Console
    ...    URL=${url}

    Take Screenshot

    Sleep    30s