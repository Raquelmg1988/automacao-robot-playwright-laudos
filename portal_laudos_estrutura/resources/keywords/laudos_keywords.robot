*** Settings ***
Library     Browser

Resource    ../locators/locators.robot
Resource    ../variables_local.robot

*** Keywords ***

Validar Tela Laudos

    Wait For Elements State
    ...    ${BTN_ADICIONAR_LAUDO}
    ...    visible
    ...    60s

Pesquisar Laudo
    [Arguments]    ${texto}

    Wait For Elements State
    ...    ${INPUT_PESQUISA}
    ...    visible
    ...    30s

    Fill Text
    ...    ${INPUT_PESQUISA}
    ...    ${texto}

    Sleep    3s

Abrir Modal Adicionar Laudo

    Wait For Elements State
    ...    ${BTN_ADICIONAR_LAUDO}
    ...    visible
    ...    20s

    Wait For Elements State
    ...    ${BTN_ADICIONAR_LAUDO}
    ...    enabled
    ...    20s

    Click
    ...    ${BTN_ADICIONAR_LAUDO}

    Wait For Elements State
    ...    ${INPUT_LOTE}
    ...    visible
    ...    30s

Preencher Lote

    Fill Text
    ...    ${INPUT_LOTE}
    ...    1

Selecionar Medicamento

    Wait For Elements State
    ...    ${SELECT_MEDICAMENTO}
    ...    visible
    ...    20s

    Click    ${SELECT_MEDICAMENTO}

    Type Text
    ...    ${SELECT_MEDICAMENTO}
    ...    CAMPO OPERATORIO

    # Aguarda o container de opções do Material UI carregar na tela
    Wait For Elements State
    ...    xpath=//ul[contains(@class, 'MuiAutocomplete-listbox')]
    ...    visible
    ...    5s

    # Seleciona o primeiro elemento de lista do tipo opção dentro do container filtrado
    Click    xpath=(//li[@role='option'])[1]

    Sleep    1s


Preencher Data Expiracao
    Wait For Elements State
    ...    ${INPUT_DATA_EXPIRACAO}
    ...    visible
    ...    20s

    Click    ${INPUT_DATA_EXPIRACAO}
    Keyboard Key    press    Control+A
    Type Text    ${INPUT_DATA_EXPIRACAO}    26/05/2027
    Keyboard Key    press    Tab

    Sleep    1s

    ${valor}=    Get Property    ${INPUT_DATA_EXPIRACAO}    value
    Log To Console    DATA_PREENCHIDA=${valor}

Anexar Laudo
    Wait For Elements State
    ...    ${INPUT_UPLOAD}
    ...    attached
    ...    20s

    Upload File By Selector
    ...    ${INPUT_UPLOAD}
    ...    ${UPLOAD_PDF_TESTE}

    Log To Console    >>> PDF ANEXADO <<<

    Sleep    3s


Salvar Laudo
    Log To Console    >>> VALIDANDO BOTAO SALVAR <<<

    Wait For Elements State    ${BTN_SALVAR}    visible    20s

    ${data}=    Get Property    ${INPUT_DATA_EXPIRACAO}    value
    Log To Console    DATA=${data}

    ${texto_botao}=    Get Text    ${BTN_SALVAR}
    Log To Console    TEXTO_BOTAO=${texto_botao}

    ${classe}=    Get Attribute    ${BTN_SALVAR}    class
    Log To Console    CLASS=${classe}

    ${disabled}=    Run Keyword And Return Status
    ...    Get Attribute
    ...    ${BTN_SALVAR}
    ...    disabled

    Log To Console    DISABLED=${disabled}

    ${required}=    Get Elements    xpath=//*[@required]
    ${total}=    Get Length    ${required}
    Log To Console    CAMPOS_REQUIRED=${total}

    ${invalidos}=    Get Elements    xpath=//*[@aria-invalid='true']
    ${count}=    Get Length    ${invalidos}
    Log To Console    CAMPOS_INVALIDOS=${count}

    Sleep    3s

    ${enabled}=    Run Keyword And Return Status
    ...    Wait For Elements State
    ...    ${BTN_SALVAR}
    ...    enabled
    ...    5s

    Log To Console    BOTAO_ENABLED=${enabled}

    IF    ${enabled}
        Click    ${BTN_SALVAR}
        Log To Console    >>> LAUDO SALVO <<<
    ELSE
        Take Screenshot
        Fail    Botão Salvar permaneceu desabilitado
    END

Adicionar Novo Laudo

    Abrir Modal Adicionar Laudo

    Preencher Lote

    Selecionar Medicamento

    Preencher Data Expiracao

    Anexar Laudo

    Salvar Laudo