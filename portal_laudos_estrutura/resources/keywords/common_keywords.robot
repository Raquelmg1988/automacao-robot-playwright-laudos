*** Settings ***
Library    Browser

*** Keywords ***

Abrir Navegador
    New Browser    chromium    headless=False
    New Context
    New Page    ${URL}
    Set Browser Timeout    60s
    Wait For Load State    networkidle

Fechar Navegador
    Close Browser

Aguardar UI Livre

    Run Keyword And Ignore Error
    ...    Wait For Load State
    ...    networkidle

    Sleep    2s
