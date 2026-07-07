# 📑 Portal Laudos - Automação de Testes (Robot Framework + Playwright)

Este repositório contém a estrutura de testes automatizados de ponta a ponta (E2E) para o **Portal Laudos**. A automação utiliza o Robot Framework com a biblioteca Browser (baseada em Playwright) e gera relatórios avançados utilizando o Allure Report.

## 🚀 Estratégia de Autenticação (MFA Bypass)

Para evitar falhas com a autenticação de duplo fator (MFA) do Office 365 no pipeline de CI/CD, utilizamos a estratégia de **Storage State**. 

1. O teste `Gerar Sessao Office365` abre o navegador de forma interativa localmente.
2. O usuário realiza o login e o MFA manualmente na tela.
3. O estado da sessão (cookies, tokens e localStorage) é salvo em um arquivo local chamado `auth_state.json`.
4. Este arquivo é ignorado pelo Git (`.gitignore`) e seu conteúdo deve ser cadastrado no GitLab CI como uma variável do tipo **File** chamada `AUTH_STATE_JSON`.

---

## 📁 Estrutura do Projeto
```text
portal_laudos/
│
├── portal_laudos_estrutura/
│   ├── resources/          # Recursos e suporte dos testes
│   │   ├── keywords/       # Keywords reutilizáveis (Ações do sistema)
│   │   ├── locators/       # Mapeamento de elementos de tela
│   │   └── variables/      # Arquivos de variáveis e templates (.example)
│   │
│   └── tests/              # Suites de testes estruturadas (.robot)
│       ├── auth/           # Geração de massa e sessão interativa
│       └── laudos/         # Validações das regras de negócio de laudos
│
├── .gitlab-ci.yml          # Configuração do Pipeline do GitLab CI
├── .gitignore              # Filtros de arquivos locais e relatórios
├── requirements.txt        # Dependências e bibliotecas Python
└── README.md               # Documentação principal do projeto
```

---

## 🛠️ Pré-requisitos Locais

Antes de rodar os testes, certifique-se de ter instalado em sua máquina:
* Python 3.10 ou superior
* Node.js 18 ou superior
* Allure Commandline (para visualizar os relatórios)

---

## 💻 Como Rodar os Testes Localmente

1. **Instale as dependências do Python:**
   ```bash
   pip install -r requirements.txt
   ```

2. **Inicialize os navegadores do Playwright:**
   ```bash
   rfbrowser init
   ```

3. **Configurar as variáveis locais:**
   Duplique o arquivo de exemplo de variáveis e configure com os dados de homologação da sua máquina:
   ```bash
   cp portal_laudos_estrutura/resources/variables_local.robot.example portal_laudos_estrutura/resources/variables_local.robot
   ```

4. **Gerar uma nova sessão (MFA):**
   ```bash
   robot -d results portal_laudos_estrutura/tests/auth/test_gerar_sessao.robot
   ```
   *(Faça o login na tela que abrir e aguarde a confirmação de sucesso no terminal).*

5. **Executar as validações do portal utilizando a sessão salva:**
   ```bash
   robot --listener allure_robotframework:allure-results -d results portal_laudos_estrutura/tests/laudos/test_laudos.robot
   ```

6. **Visualizar o Relatório Allure:**
   ```bash
   allure serve allure-results
   ```

---

## 🔄 Pipeline (GitLab CI/CD)

O pipeline está configurado no arquivo `.gitlab-ci.yml`. Ele roda os testes de forma automatizada e em modo oculto (`headless`), gerando o Allure Report como um artefato disponível para download por até 7 dias após a execução.
