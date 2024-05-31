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

# function
lambda_deploy:
	./scripts/function/lambda_deploy.sh

lambda_update:
	./scripts/function/lambda_update.sh

lambda_invoke:
	./scripts/function/lambda_invoke.sh

# call with arg like so: 
# make lambda_get_one arg=function_name
lambda_get_one:
	./scripts/lambda/lambda_get_one.sh $(arg) 

lambda_get_all:
	./scripts/lambda/lambda_get_all.sh

# call with arg like so:
# make lambda_delete_one arg=function_name
lambda_delete_one:
	./scripts/lambda/lambda_delete_one.sh $(arg)

lambda_delete_all:
	./scripts/lambda/lambda_delete_function.sh

# api
# call with arg like so: 
# make lambda_get_one arg=function_name
api_get_one:
	./scripts/api/api_get_one.sh $(arg) 

api_get_all:
	./scripts/api/api_get_all.sh

# call with arg like so:
# make api_delete_one arg=function_name
api_delete_one:
	./scripts/api/api_delete_one.sh $(arg)

api_delete_all:
	./scripts/api/api_delete_function.sh

clean:
	./scripts/clean.sh	

check_variables:
	./scripts/check_variables.sh

cdk_bootstrap:
	./scripts/cdk_bootstrap.sh

.PHONY: all executable aws_sso_login dev test install deploy update invoke list delete delete_all clean check_variables cdk_bootstrap

