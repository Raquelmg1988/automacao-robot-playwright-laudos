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

    Wait For Elements State
    ...    ${BTN_LOGIN_OFFICE}
    ...    visible
    ...    30s

    Click
    ...    ${BTN_LOGIN_OFFICE}

    Log To Console
    ...    >>> APROVE O MFA E AGUARDE O PORTAL <<<