POOL_NAME?=${APP_NAME}
CLIENT_NAME?=${APP_NAME}-client
STAGE?=dev
BUILD_DIR?=/tmp/build/${APP_NAME}/${STAGE}
PYTHON_VERSION?=3.14
BUILD_OPTIONS?=--only-binary=:all: --platform linux/amd64  
BUILD_OPTIONS+=--implementation cp --python-version ${PYTHON_VERSION}

init_user_pool:
	python -m app.scripts.initialize_user_pool --email ${ADMIN_EMAIL} --password ${ADMIN_PASSWORD} --user-pool ${POOL_NAME} --client-name ${CLIENT_NAME}
.PHONY: init_user_pool

STAGE?=local
create_tables:
	python -m app.scripts.create_tables --stage ${STAGE}
.PHONY: create_tables

purge_tables:
	python -m app.scripts.purge_tables
.PHONY: purge_tables

purge_user_pools:
	python -m app.scripts.purge_user_pools
.PHONY: purge_user_pools

package:
	mkdir -p ${BUILD_DIR}
	pip install -r requirements.txt ${BUILD_OPTIONS} -t ${BUILD_DIR}
	cp -r app ${BUILD_DIR}
	cd ${BUILD_DIR} && zip -r ../${APP_NAME}_${STAGE}.zip .
.PHONY: package

clean:
	rm -rf ${BUILD_DIR}
.PHONY: clean

deploy:
	aws s3 cp ${BUILD_DIR}/${APP_NAME}.zip s3://${MANAGEMENT_BUCKET}/app/${APP_NAME}/${APP_NAME}.zip
.PHONY: deploy



