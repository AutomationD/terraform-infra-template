# NOTE: You can override any variable via GNUMakefile

ENV ?= dev
ENV_PREFIX ?= demo
AWS_PROFILE ?= $(ENV_PREFIX)-$(ENV)

deploy: infra.deploy

infra.init:
	@ cd .infra/env/$(ENV) && \
	cat backend.tf.tmpl | $(ENVSUBST) > backend.tf && \
	$(TERRAFORM) init -input=true

infra.deploy: infra.init ## Deploy infrastrcture
	@ cd .infra/env/$(ENV) && \
	TF_VAR_env="$(ENV)" \
	TF_VAR_aws_profile="$(AWS_PROFILE)" \
	TF_VAR_ec2_key_pair_name="$(ENV_PREFIX)-$(ENV)" \
	TF_VAR_ssh_public_key="$(TF_VAR_ssh_public_key)" \
	$(TERRAFORM) plan -out=tfplan -input=false && \
	$(TERRAFORM) apply -input=false tfplan

ENVSUBST ?= $(shell which envsubst)
TERRAFORM ?= $(shell which terraform)
