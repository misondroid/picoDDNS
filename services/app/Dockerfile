FROM ghcr.io/opentofu/opentofu:minimal AS tofu

FROM node:24-alpine AS base
ARG USER_NAME=app
ARG USER_HOME=/home/${USER_NAME}
ARG USER_ID=1000
ARG GROUP_NAME=app
ARG GROUP_ID=1000
ARG DIALOUT_GROUP_ID=20
COPY ./services/app/packages/base/apk.txt /tmp
RUN set -xe && apk update &&apk add --no-cache $(cat /tmp/apk.txt) &&\
    rm -rf /tmp/base-apk.txt &&\
    usermod -u ${USER_ID} -l ${USER_NAME} -d /home/${USER_NAME} -m node && \
    if [ ${GROUP_ID} -eq ${DIALOUT_GROUP_ID} ]; then \
        groupdel dialout 2>/dev/null || true && \
        groupmod -g ${GROUP_ID} -n ${GROUP_NAME} node; \
    else \
        groupmod -g ${GROUP_ID} -n ${GROUP_NAME} node; \
    fi && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER_NAME}
    
#ローカル開発環境
# python / OpenTofu を使用したローカル開発&インフラ管理環境
FROM base AS local
COPY --from=tofu /usr/local/bin/tofu /usr/local/bin/tofu
COPY ./services/app/packages/local /tmp/local
ARG AWS_ACCESS_KEY_ID=test
ARG AWS_SECRET_ACCESS_KEY=test
ARG AWS_REGION=ap-northeast-1
ARG PIP_INSTALL_OPTIONS="--no-cache-dir --break-system-packages --pre"
COPY ./code/backend/requirements.txt /tmp/
RUN set -xe && apk add --no-cache $(cat /tmp/local/apk.txt) && \
    pip install ${PIP_INSTALL_OPTIONS} -r /tmp/requirements.txt && \
    rm -rf /tmp/requirements.txt
WORKDIR /app
COPY --from=tofu /usr/local/bin/tofu /usr/local/bin/tofu
COPY ./services/common/bashrc ${USER_HOME}/.bashrc
COPY ./services/app/aws/config ${USER_HOME}/.aws/config
COPY ./services/app/aws/credentials ${USER_HOME}/.aws/credentials
COPY ./code/backend/package.json .
COPY ./code/backend/serverless.yml .
RUN sudo npm install -g $(cat /tmp/local/npm-global.txt) && \
  sls plugin install -n $(cat /tmp/local/sls-plugins.txt) && npm install && \
  rm -rf /tmp/local
USER ${USER_NAME}
CMD ["bash"]
