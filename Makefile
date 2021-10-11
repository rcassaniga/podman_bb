IMG=rcassaniga/podman_bb:latest
CONTAINER_NAME=warsaw_bb
DOCKERCMD=podman
SHARED_FOLDER=$(HOME)/BBShare


USER_UID = $(shell id -u $(USER))
USER_GID = $(shell id -g $(USER))
ifeq ($(shell uname),Darwin)
	USER_GID = $(shell id -u $(USER))
endif

build:
	$(DOCKERCMD) build -t ${IMG} .
	mkdir -p $(SHARED_FOLDER)
	$(DOCKERCMD) unshare chown $(USER_UID):$(USER_GID) $(SHARED_FOLDER)

start:
	$(DOCKERCMD) run -d  --rm -it --name ${CONTAINER_NAME} \
		--cap-add CAP_AUDIT_WRITE  --cap-add  CAP_SYS_PTRACE  \
		-e USER_UID=$(USER_UID) \
		-e USER_GID=$(USER_GID) \
		-v "$(XAUTHORITY):/root/.Xauthority:ro" \
		-v "/tmp/.X11-unix:/tmp/.X11-unix:ro" \
		-v "/etc/machine-id:/etc/machine-id:ro" \
		-v "$(SHARED_FOLDER):/home/user/Downloads:rw" \
		$(IMG) seg.bb.com.br
logs:
	$(DOCKERCMD) logs -f ${CONTAINER_NAME}

shell:
	$(DOCKERCMD) exec -it ${CONTAINER_NAME} bash

stop:
	-$(DOCKERCMD) kill ${CONTAINER_NAME}

remove:
	-$(DOCKERCMD) image rm ${CONTAINER_NAME}

