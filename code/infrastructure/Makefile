TF_CMD:=tofu
ENV?=dev
BACKEND_CONF:=./backend/${ENV}.conf
VAR_FILE:=./vars/${ENV}.tfvars

init:
	${TF_CMD} init -backend-config=${BACKEND_CONF} -var-file=${VAR_FILE}
.PHONY: init

validate:
	${TF_CMD} validate
.PHONY: validate

plan:
	${TF_CMD} plan -var-file=${VAR_FILE}
.PHONY: plan

apply:
	${TF_CMD} apply -var-file=${VAR_FILE}
.PHONY: apply

destroy:
	${TF_CMD} destroy -var-file=${VAR_FILE}
.PHONY: destroy

