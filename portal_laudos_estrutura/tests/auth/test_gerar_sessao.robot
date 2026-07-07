*** Settings ***
Library     Browser
Library     OperatingSystem
Resource    ../../resources/keywords/login_laudos_keywords.robot

*** Test Cases ***

Gerar Sessao Office365

    Abrir Portal Laudos

    Login Office365 Manual

    Log To Console
    ...    >>> FAÇA LOGIN + MFA E ESPERE O PORTAL <<<

    Wait For Elements State
    ...    xpath=//button[contains(.,'Adicionar Laudo')]
    ...    visible
    ...    180s

    Log To Console
    ...    >>> PORTAL ABERTO - SALVANDO SESSAO <<<

    ${state}=    Save Storage State

    Copy File
    ...    ${state}
    ...    ${AUTH_STATE_JSON}

    Log To Console
    ...    >>> SESSAO SALVA COM SUCESSO <<<