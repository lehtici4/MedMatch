# MedMatch

Sistema web de agendamento de consultas médicas desenvolvido como projeto acadêmico de Cibersegurança.

O objetivo do MedMatch é centralizar o fluxo de cadastro, autenticação, listagem de médicos, visualização de horários, agendamento e cancelamento de consultas, utilizando uma arquitetura baseada em microsserviços, containers Docker e deploy em Kubernetes.

## Status do projeto

Status atual da entrega:

* Pipeline CI/CD no GitHub Actions: funcionando
* Build e push de imagens Docker: funcionando
* Deploy automatizado no Kubernetes: funcionando
* Kubernetes local via Docker Desktop: funcionando
* Frontend acessível via port-forward: funcionando
* Cadastro de usuário: validado
* Login: validado
* Marcação de consulta: validada
* Cancelamento de consulta: validado

Última validação na branch `main`:

* CI — Testes, SAST e SCA: sucesso
* CD — Build e Push das imagens Docker: sucesso
* CD — Deploy no Kubernetes: sucesso

## Arquitetura

O projeto utiliza uma arquitetura baseada em microsserviços.

Componentes principais:

* Frontend web
* API Gateway
* Serviço de autenticação
* Serviço de recuperação de senha
* Serviço de médicos e especialidades
* Serviço de agendamento
* Banco de dados de credenciais
* Banco de dados de médicos
* Banco de dados de agendamentos

A comunicação entre os componentes é feita por APIs HTTP/REST. O frontend se comunica com o gateway, e o gateway encaminha as requisições para os microsserviços internos.

## Microsserviços

### Frontend

Interface web utilizada pelo usuário para:

* Criar cadastro
* Fazer login
* Visualizar médicos
* Agendar consulta
* Cancelar consulta

Tecnologias:

* React
* Vite
* Nginx
* Docker

### Gateway

Serviço de entrada da aplicação.

Responsabilidades:

* Receber as chamadas do frontend
* Encaminhar requisições para os microsserviços internos
* Centralizar a comunicação entre frontend e backend

Tecnologias:

* Python
* FastAPI
* Docker

### Auth Service

Serviço responsável por:

* Cadastro de usuários
* Login
* Emissão/validação de token JWT
* Integração com banco de credenciais

Tecnologias:

* Python
* FastAPI
* MySQL
* JWT

### Recovery Service

Serviço responsável pelo fluxo de recuperação de acesso.

Tecnologias:

* Python
* FastAPI
* MySQL

### Doctors Service

Serviço responsável por:

* Listagem de médicos
* Listagem de especialidades
* Dados demonstrativos de médicos

Tecnologias:

* Python
* FastAPI
* MySQL

### Schedule Service

Serviço responsável por:

* Consulta de horários
* Agendamento de consultas
* Cancelamento de consultas
* Controle de status de consultas

Tecnologias:

* Python
* FastAPI
* MySQL

## Bancos de dados

O projeto utiliza bancos MySQL separados por domínio:

* `credentials-db`
* `doctors-db`
* `scheduling-db`

Cada banco possui seu próprio volume persistente no Kubernetes por meio de PVC.

PVCs esperados:

* `credentials-db-pvc`
* `doctors-db-pvc`
* `scheduling-db-pvc`

## Imagens Docker

As imagens são construídas e enviadas para o Docker Hub pela pipeline.

Imagens do projeto:

* `medmatch-auth`
* `medmatch-doctors`
* `medmatch-schedule`
* `medmatch-recovery`
* `medmatch-gateway`
* `medmatch-frontend`

## Kubernetes

O deploy atual utiliza Kubernetes local do Docker Desktop.

Contexto esperado:

```bash
docker-desktop
```

Namespace utilizado:

```bash
medmatch
```

Arquivos principais de Kubernetes:

```text
k8s/database.yaml
k8s/deployments.yaml
k8s/frontend.yaml
k8s/gateway.yaml
```

## GitHub Actions

O projeto possui pipeline CI/CD em:

```text
.github/workflows/pipeline.yml
```

A pipeline executa:

1. Checkout do código
2. Preparação de ambiente Python local via `venv`
3. Testes e validações
4. SAST
5. SCA
6. Login no Docker Hub
7. Build das imagens Docker
8. Push das imagens Docker
9. Deploy no Kubernetes

## Secrets necessários

Os valores sensíveis não devem ser versionados no repositório.

Secrets esperados no GitHub Actions:

```text
DOCKER_USERNAME
DOCKER_PASSWORD
KUBECONFIG_B64
DB_USER
DB_PASSWORD
DB_ROOT_PASSWORD
JWT_SECRET
```

Observações:

* `DOCKER_USERNAME` deve ser o usuário do Docker Hub.
* `DOCKER_PASSWORD` deve ser preferencialmente um Access Token do Docker Hub com permissão Read & Write.
* `KUBECONFIG_B64` contém o kubeconfig convertido para Base64.
* As credenciais de banco e JWT são injetadas como Kubernetes Secrets durante o deploy.

## Como validar o ambiente local

Entrar no projeto:

```bash
cd ~/MedMatch
```

Confirmar contexto Kubernetes:

```bash
kubectl config current-context
```

Resultado esperado:

```text
docker-desktop
```

Confirmar node Kubernetes:

```bash
kubectl get nodes
```

Resultado esperado:

```text
STATUS: Ready
```

Validar recursos do projeto:

```bash
kubectl get pods,svc,pvc -n medmatch
```

Resultado esperado:

* Pods em `Running`
* Services criados
* PVCs em `Bound`

## Como acessar a aplicação

Abrir o frontend com port-forward:

```bash
kubectl port-forward -n medmatch svc/frontend 8081:80
```

Acessar no navegador:

```text
http://localhost:8081
```

Opcionalmente, abrir o gateway:

```bash
kubectl port-forward -n medmatch svc/gateway 30080:80
```

Gateway:

```text
http://localhost:30080
```

## Fluxo validado

Fluxo funcional validado na aplicação:

1. Cadastro de usuário
2. Login
3. Visualização de médicos/especialidades
4. Agendamento de consulta
5. Visualização da consulta marcada
6. Cancelamento da consulta

## Comandos úteis para evidência

Status dos pods:

```bash
kubectl get pods -n medmatch
```

Services e PVCs:

```bash
kubectl get svc,pvc -n medmatch
```

Node Kubernetes:

```bash
kubectl get nodes -o wide
```

Services detalhados:

```bash
kubectl get svc -n medmatch -o wide
```

PVCs:

```bash
kubectl get pvc -n medmatch
```

Últimos commits:

```bash
git log --oneline -5
```

Status Git:

```bash
git status --short
```

## Runner self-hosted

O projeto utiliza runner self-hosted no WSL.

Para iniciar o runner:

```bash
cd ~/actions-runner
./run.sh
```

O terminal deve permanecer aberto.

Resultado esperado:

```text
Listening for Jobs
```

Observação: como o runner é local, a pipeline depende do notebook ligado, WSL ativo, Docker Desktop aberto e terminal do runner aberto.

## Warnings conhecidos

Durante a pipeline podem aparecer warnings que não impedem a execução:

* Aviso de depreciação do Node.js 20 em actions antigas
* Aviso de artifact não encontrado para relatório Semgrep, quando não houver artefato gerado

Esses avisos não impediram a pipeline final de passar com sucesso.

## Segurança aplicada

Cuidados implementados no projeto:

* Secrets removidos do código e tratados via GitHub Secrets
* Kubernetes Secrets criados durante o deploy
* JWT Secret tratado como variável sensível
* Credenciais de banco não versionadas no repositório
* Atualização de dependências Python para compatibilidade com Python 3.13
* Correção do pipeline para evitar interpolação insegura de secrets diretamente no shell
* Separação dos bancos por domínio funcional
* Uso de volumes persistentes para os bancos no Kubernetes

## Autores

Fábio Roberto Ferreira
Leticia Vieira

Projeto desenvolvido para a disciplina de Devsecops — PUCPR.
