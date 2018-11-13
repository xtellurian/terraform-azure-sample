# this dockerfile builds the image used as a CLI

FROM microsoft/azure-cli:2.0.49

RUN wget https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip \
    && mkdir terraform \ 
    && unzip terraform_0.11.10_linux_amd64.zip -d terraform \
    && alias tf=terraform

RUN az aks install-cli

RUN wget https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz && \
    tar -zxvf helm-v2.11.0-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm
    
ENV PATH="/terraform:${PATH}"
