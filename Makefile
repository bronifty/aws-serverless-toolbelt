# Makefile
all: executable update init go nats aws softwares nex clean check vim cpufreq sshkey docker cdk

executable:
	chmod -R +x .

install: 
	./scripts/install.sh

deploy:
	./scripts/lambda_deploy.sh

update:
	./scripts/lambda_update.sh

init:
	./scripts/init.sh

clean:
	./scripts/clean.sh

check:
	./scripts/check.sh

.PHONY: all executable update init go nats aws softwares nex clean check vim cpufreq sshkey docker cdk

