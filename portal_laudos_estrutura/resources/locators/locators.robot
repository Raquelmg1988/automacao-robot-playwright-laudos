*** Variables ***

# LOGIN
${BTN_LOGIN_OFFICE}
...    xpath=//button[contains(.,'Entrar com Office 365')]

# HOME
${BTN_ADICIONAR_LAUDO}
...    xpath=//button[contains(@class,'btn-add-batch') and contains(.,'Adicionar Laudo')]

${INPUT_PESQUISA}
...    xpath=(//input[contains(@class,'MuiInputBase-input')])[1]

${LINHAS_LAUDOS}
...    xpath=//table//tbody//tr

# MODAL LAUDO
${MODAL_LAUDO}
...    xpath=//button[contains(.,'Salvar')]

${INPUT_LOTE}
...    xpath=//input[@required and @type='text' and not(@disabled)][1]

${SELECT_MEDICAMENTO}
...    xpath=//input[@role='combobox']

${INPUT_LABORATORIO}
...    xpath=//input[@disabled and @readonly]

${INPUT_DATA_EXPIRACAO}
...    xpath=//input[@type='date']

${INPUT_UPLOAD}
...    xpath=//input[@type='file']

${BTN_SALVAR}
...    xpath=//button[contains(.,'Salvar')]

${BTN_CANCELAR}
...    xpath=//button[contains(.,'Cancelar')]