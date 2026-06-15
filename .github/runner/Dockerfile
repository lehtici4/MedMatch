FROM debian:12

ARG RUNNER_VERSION=2.334.0
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl wget git sudo ca-certificates \
    gnupg lsb-release unzip jq \
    python3 python3-pip python3-venv \
    libicu72 \
    && rm -rf /var/lib/apt/lists/*

# Docker CLI
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && apt-get install -y docker-ce-cli docker-compose-plugin && \
    rm -rf /var/lib/apt/lists/*

# kubectl
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.34/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes.gpg] https://pkgs.k8s.io/core:/stable:/v1.34/deb/ /" > /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && apt-get install -y kubectl && \
    rm -rf /var/lib/apt/lists/*

# Usuário devsecops — instrução USER numa linha separada
RUN useradd -m -s /bin/bash devsecops && \
    echo "devsecops ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER devsecops
WORKDIR /home/devsecops

# Instala o runner em /actions-runner (raiz) para bater com o entrypoint.sh
RUN sudo mkdir /actions-runner && sudo chown devsecops:devsecops /actions-runner && \
    cd /actions-runner && \
    curl -o runner.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf runner.tar.gz && \
    rm runner.tar.gz

WORKDIR /actions-runner

COPY entrypoint.sh /home/devsecops/entrypoint.sh
RUN sudo chmod +x /home/devsecops/entrypoint.sh

ENTRYPOINT ["/home/devsecops/entrypoint.sh"]