# Makefile
all: executable install deploy update

executable:
	chmod -R +x .

install: 
	./scripts/install.sh

deploy:
	./scripts/lambda_deploy.sh

update:
	./scripts/lambda_update.sh

.PHONY: all executable install deploy update

