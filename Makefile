# Makefile
all: executable aws_sso_login dev install deploy update clean test_variables lambda_list_functions lambda_delete_function lambda_delete_all

executable:
	chmod -R +x .

aws_sso_login:
	./scripts/aws_sso_login.sh

dev:
	./scripts/dev.sh

install: 
	./scripts/install.sh

deploy:
	./scripts/lambda_deploy.sh

update:
	./scripts/lambda_update.sh

clean:
	./scripts/clean.sh	

test_variables:
	./scripts/test_variables.sh

lambda_list_functions:
	./scripts/lambda_list_functions.sh

lambda_delete_function:
	./scripts/lambda_delete_function.sh

lambda_delete_all:
	./scripts/lambda_delete_all.sh	

.PHONY: all executable aws_sso_login dev install deploy update clean test_variables lambda_list_functions lambda_delete_function lambda_delete_all

