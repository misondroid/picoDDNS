FROM ghcr.io/opentofu/opentofu:minimal AS tofu
FROM node:24-alpine AS base
ARG USER_NAME=app
ARG USER_HOME=/home/${USER_NAME}
ARG USER_ID=1000
ARG GROUP_NAME=app
ARG GROUP_ID=1000
ARG NPM_GLOBAL_PACKAGES="aws-cdk"
RUN set -xe && apk update &&apk add --no-cache bash shadow sudo &&\
    usermod -u ${USER_ID} -l ${USER_NAME} -d /home/${USER_NAME} -m node && \
    groupmod -g ${GROUP_ID} -n ${GROUP_NAME} node && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER_NAME} && \
    npm -g install ${NPM_GLOBAL_PACKAGES}
    
#ローカル開発環境
FROM base AS local
WORKDIR /app
USER ${USER_NAME}
COPY --from=tofu /usr/local/bin/tofu /usr/local/bin/tofu
COPY ./services/common/bashrc ${USER_HOME}/.bashrc
CMD ["bash"]