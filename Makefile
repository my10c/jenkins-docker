
include include/makefile.inc

all:
	@echo "\n\t *** valid options are: build run start stop status shell ***"
	@echo "\t *** use these options with caution: clean clean-all ***\n"

build: 
	@echo "\t *** build image using file: $(DOCKERFILE) ***\n"
	@docker build --network=host --no-cache --pull -f $(DOCKERFILE) \
		--build-arg "JENKINSMODEL=$(JENKINSMODEL)" \
		--build-arg "VERSION=$(VERSION)" \
		-t $(TAG) .
	@echo "-----------------"
	@docker images
	@echo "-----------------"

run:
	@echo "\t *** runing image $(TAG) with namespace $(NAMESPACE) ***\n"
	@echo "-----------------"
	@docker run --network=host --detach \
		--name $(NAMESPACE) $(TAG)
	@echo "-----------------"
	@docker ps -a
	@echo "-----------------"

start:
	@echo "\t *** starting the container $(TAG) ***\n"
	@$(eval DOCKERID=$(shell sh -c "docker ps -a | grep '$(TAG)'" | awk '{print $$1;}'))
	@echo "-----------------"
	@docker start $(DOCKERID)
	@echo "-----------------"
	@docker ps -a
	@echo "-----------------"

stop:
	@echo "\t *** stoping the container $(TAG) ***\n"
	@$(eval DOCKERID=$(shell sh -c "docker ps -a | grep '$(TAG)'" | awk '{print $$1;}'))
	@echo "-----------------"
	@docker stop $(DOCKERID)
	@echo "-----------------"
	@docker ps -a
	@echo "-----------------"

status:
	@echo "\t *** status of the container $(TAG) ***\n"
	@echo "-----------------"
	@docker ps -a
	@echo "-----------------"

shell:
	@echo "\t *** shelling into the container $(TAG) ***\n"
	@$(eval DOCKERID=$(shell sh -c "docker ps -a | grep '$(TAG)'" | awk '{print $$1;}'))
	@docker exec -u 0 -ti $(DOCKERID) /bin/bash

clean:
	@echo "\t *** cleaning all containers and images for $(TAG) *** \n"
	@$(eval DOCKERID=$(shell sh -c "docker ps -a | grep '$(TAG)'" | awk '{print $$1;}'))
	@if [ ! -z $(DOCKERID) ] ; then \
		docker rm -f $(DOCKERID) >/dev/null 2>&1 ;\
		docker rmi -f $(DOCKERID) >/dev/null 2>&1 ;\
	fi
	@echo "-----------------"
	@docker ps -a
	@echo "-----------------"
	@docker images
	@echo "-----------------"

logs:
	@echo "\t *** logs from container *** \n"
	@$(eval DOCKERID=$(shell sh -c "docker ps -a | grep '$(TAG)'" | awk '{print $$1;}'))
	@docker logs $(LOG_OPTION) $(DOCKERID)
