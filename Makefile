all:

.PHONY: 

docker_image: Dockerfile
	docker build -t terraform:latest --network host .