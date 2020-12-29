FROM debian:stable-slim

ARG TERRAFORM_VERSION=0.13.5
ARG TERRAGRUNT_VERSION=0.25.5

RUN \
	# Update
	apt-get update -y && \
	# Install dependencies
	apt-get install make unzip wget git ssh -y

################################
# InstalENTRYPOINTl Terraform
################################

# Download terraform for linux
RUN wget --progress=dot:mega https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN \
	# Unzip
	unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
	# Move to local bin
	mv terraform /usr/local/bin/ && \
	# Make it executable
	chmod +x /usr/local/bin/terraform && \
	# Check that it's installed
	terraform --version

################################
# Install Terragrunt
################################

# Download terragrunt for linux
RUN wget --progress=dot:mega https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64

RUN \
	# Move to local bin
	mv terragrunt_linux_amd64 /usr/local/bin/terragrunt && \
	# Make it executable
	chmod +x /usr/local/bin/terragrunt && \
	# Check that it's installed
	terragrunt --version

RUN mkdir -p /workspace

WORKDIR /workspace

COPY Makefile /workspace/Makefile
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["make"]

LABEL org.opencontainers.image.source https://github.com/metacron/terraform-action
