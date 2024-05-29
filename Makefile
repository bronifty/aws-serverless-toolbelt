# Makefile
all: executable install deploy update clean

executable:
	chmod -R +x .

install: 
	./scripts/install.sh

deploy:
	./scripts/lambda_deploy.sh

update:
	./scripts/lambda_update.sh

clean:
	./scripts/clean.sh	

test-variables:
	./scripts/test-variables.sh

.PHONY: all executable install deploy update clean test-variables

