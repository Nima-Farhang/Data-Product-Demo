FROM mcr.microsoft.com/devcontainers/base:ubuntu

ARG TERRAFORM_VERSION=1.9.6

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    unzip \
    gnupg \
    ca-certificates \
    file \
    python3 \
    python3-pip \
    python3-venv \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o /tmp/terraform.zip \
    && unzip /tmp/terraform.zip -d /usr/local/bin \
    && rm -f /tmp/terraform.zip \
    && chmod +x /usr/local/bin/terraform

COPY .devcontainer/requirements.txt /tmp/requirements.txt

RUN python3 -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir --upgrade pip \
    && /opt/venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt \
    && rm -f /tmp/requirements.txt

ENV PATH="/opt/venv/bin:${PATH}"

CMD ["/bin/bash"]