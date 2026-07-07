*** Settings ***
Library     Browser

Resource    ../variables_local.robot
Resource    ../locators/locators.robot
Resource    common_keywords.robot


*** Keywords ***

Abrir Portal Laudos

    New Browser
    ...    chromium
    ...    headless=False

    New Context

    New Page
    ...    ${URL}

    Wait For Load State
    ...    networkidle

    Aguardar UI Livre


Login Office365 Manual

    # Verifica se o botão "Entrar com Office 365" está visível na tela em até 5 segundos
    ${botao_presente}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${BTN_LOGIN_OFFICE}    visible    5s

    # Se o botão estiver lá, faz o clique padrão
    IF    ${botao_presente}
        Click    ${BTN_LOGIN_OFFICE}
        Log To Console    >>> CLICADO NO BOTAO OFFICE 365 <<<
    ELSE
        Log To Console    >>> REDIRECIONADO DIRETO PARA A TELA DA MICROSOFT <<<
    END

    Log To Console
    ...    >>> APROVE MFA E AGUARDE O PORTAL <<<


Abrir Sessao Logada Laudos

    New Browser
    ...    chromium
    ...    headless=False

    New Context
    ...    storageState=${AUTH_STATE_JSON}

    New Page
    ...    ${URL}

    Wait For Load State
    ...    networkidle

    Log To Console
    ...    >>> VALIDANDO SESSAO <<<

    ${office}=    Get Element Count
    ...    xpath=//button[contains(.,'Entrar com Office 365')]

    IF    ${office} > 0

        Log To Console
        ...    >>> SESSAO EXPIRADA - LOGIN NECESSARIO <<<

        Click
        ...    xpath=//button[contains(.,'Entrar com Office 365')]

        Wait For Elements State
        ...    xpath=//button[contains(.,'Adicionar Laudo')]
        ...    visible
        ...    120s

    END

    Wait For Elements State
    ...    xpath=//button[contains(.,'Adicionar Laudo')]
    ...    visible
    ...    60s

    Log To Console
    ...    >>> PORTAL CARREGADO <<<