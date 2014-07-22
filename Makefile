.PHONY: all docker

docker: Dockerfile
	docker build --rm -t morshed/farnsworth .

