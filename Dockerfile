FROM debian:stable-slim

ARG TERRAFORM_VERSION=0.13.5
ARG TERRAGRUNT_VERSION=0.25.5
ARG PYTHON_VERSION=3.8.2
ARG PYTHON_EXECUTABLE_VERSION=3.8

ENV PATH="/root/.local/bin:${PATH}"

RUN \
	# Update
	apt-get update -y && \
	# Install general dependencies
	apt-get install -y unzip wget git ssh && \
	# Install Python dependencies
	apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev

################################
# Instal Terraform
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

################################
# Install Python and pip
################################

# Download terragrunt for linux
RUN wget --progress=dot:mega https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz

RUN \
	# Extract
	tar -xf Python-${PYTHON_VERSION}.tar.xz && \
	# Enter directory, configure, build, install
	cd Python-${PYTHON_VERSION} && \
	./configure --enable-optmizations && \
	make -j 4 && \
	make altinstall && \
	# Symbolic link to "python" command
	ln -s /usr/local/bin/python${PYTHON_EXECUTABLE_VERSION} /usr/local/bin/python && \
	python --version

# Install pip
RUN \
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
	python get-pip.py && \
	python -m pip install --upgrade pip setuptools wheel

################################
# Install Ansible
################################

RUN \
	python -m pip install ansible && \
	ansible --version

RUN mkdir -p /workspace

WORKDIR /workspace

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["terragrunt"]

LABEL org.opencontainers.image.source https://github.com/metacron/terraform-action
