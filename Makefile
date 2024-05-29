# Makefile
all: executable aws_sso_login dev test install deploy update invoke list delete delete_all clean check_variables 

executable:
	chmod -R +x .

aws_sso_login:
	./scripts/aws_sso_login.sh

dev:
	./scripts/dev.sh

test:
	./scripts/test.sh

install: 
	./scripts/install.sh

deploy:
	./scripts/lambda_deploy.sh

update:
	./scripts/lambda_update.sh

invoke:
	./scripts/lambda_invoke.sh

list:
	./scripts/lambda_list_functions.sh

delete:
	./scripts/lambda_delete_function.sh

delete_all:
	./scripts/lambda_delete_all.sh	

clean:
	./scripts/clean.sh	

check_variables:
	./scripts/check_variables.sh

.PHONY: all executable aws_sso_login dev test install deploy update invoke list delete delete_all clean check_variables 

