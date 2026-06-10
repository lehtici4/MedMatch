FROM debian:12

#ARG define a versão do runner como variável de build. 
#ENV evita que o apt faça perguntas interativas durante a instalação.
ARG RUNNER_VERSION=2.334.0
ENV DEBIAN_FRONTEND=noninteractive

#Instala as ferramentas base que o runner vai precisar para executar os jobs da pipeline. 
#O rm no final limpa o cache do apt para deixar a imagem menor.
RUN apt-get update && apt-get install -y \
    curl wget git sudo ca-certificates \
    gnupg lsb-release unzip jq \
    python3 python3-pip python3-venv \
    libicu72 \
    && rm -rf /var/lib/apt/lists/*

# Instala o Docker CLI dentro do runner. 
#Isso é necessário porque a pipeline vai precisar fazer docker build e docker push das imagens dos microsserviços.
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && apt-get install -y docker-ce-cli docker-compose-plugin && \
    rm -rf /var/lib/apt/lists/*

# Instala o kubectl dentro do runner. 
#A pipeline vai precisar dele para aplicar os manifests do Kubernetes e fazer o deploy dos microsserviços.
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.34/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes.gpg] https://pkgs.k8s.io/core:/stable:/v1.34/deb/ /" > /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && apt-get install -y kubectl && \
    rm -rf /var/lib/apt/lists/*

#Cria o usuário devsecops (igual à VM do professor) e muda para ele. 
#Nunca rodamos processos como root em containers por segurança.
RUN useradd -m -s /bin/bash devsecops && \
    echo "devsecops ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#Cria o usuário devsecops (igual à VM do professor) e muda para ele. 
USER devsecops
WORKDIR /home/devsecops

#Baixa e extrai o GitHub Actions Runner dentro do container. 
#O entrypoint.sh é o script que vai rodar quando o container iniciar, registrando e iniciando o runner automaticamente.
RUN mkdir actions-runner && cd actions-runner && \
    curl -o runner.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf runner.tar.gz && \
    rm runner.tar.gz

WORKDIR /home/devsecops/actions-runner

COPY entrypoint.sh ../entrypoint.sh
RUN sudo chmod +x ../entrypoint.sh

ENTRYPOINT ["/home/devsecops/entrypoint.sh"]