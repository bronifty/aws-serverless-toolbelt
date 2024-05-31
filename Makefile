# Makefile
all: executable aws-sso-login app-dev app-test app-install app-deploy app-update app-invoke app-list app-delete app-delete-all clean check-variables cdk-bootstrap

executable:
	chmod -R +x .

aws-sso-login:
	./scripts/aws-sso-login.sh

check-variables:
	./scripts/check-variables.sh

cdk-bootstrap:
	./scripts/cdk-bootstrap.sh

app-clean:
	./scripts/app-clean.sh	

app-dev:
	./scripts/app-dev.sh

app-test:
	./scripts/app-test.sh

app-install: 
	./scripts/app-install.sh

# functions 
# call with function=<function-name>
# eg make function-deploy function=my-function
# a call with no args will have default args applied from the variables file
function-deploy:
	./scripts/function/function-deploy.sh $(function)

function-update:
	./scripts/function/function-update.sh $(function)

function-invoke:
	./scripts/function/function-invoke.sh $(function)

function-get-one:
	./scripts/function/function-get-one.sh $(function) 

function-get-all:
	./scripts/function/function-get-all.sh

function-delete-one:
	./scripts/function/function-delete-one.sh $(function)

function-delete-all:
	./scripts/function/function-delete-function.sh

# apis 
# call with api=<api-name> function=<function-name>
# eg make api-add-one api=my-api function=my-function
api-add-one:
	./scripts/api/api-add-one.sh $(api) $(function)

api-get-one:
	./scripts/api/api-get-one.sh $(api) 

api-get-all:
	./scripts/api/api-get-all.sh

api-delete-one:
	./scripts/api/api-delete-one.sh $(api)

api-delete-all:
	./scripts/api/api-delete-function.sh

.PHONY: all executable aws-sso-login app-dev app-test app-install app-deploy app-update app-invoke app-list app-delete app-delete-all clean check-variables cdk-bootstrap

