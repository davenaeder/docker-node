REPOSITORY = iheartradio/node
TAG = $(n)-$(b)

default: all

all: base onbuild

base: IMAGE_NAME = $(REPOSITORY):$(TAG)
base:
	docker build --build-arg NODE_VERSION=$(n) -t $(IMAGE_NAME) .
	docker push $(IMAGE_NAME)
	# tag latest image for badges etc.
	docker tag $(IMAGE_NAME) $(REPOSITORY):latest
	docker push $(REPOSITORY):latest

onbuild: IMAGE_NAME = $(REPOSITORY):$(TAG)-onbuild
onbuild: base
	cd onbuild && \
		sed 's/NODE_VERSION/$(TAG)/g' Dockerfile | \
		docker build -t $(IMAGE_NAME) -
	docker push $(IMAGE_NAME)

.PHONY: all base onbuild

# TODO: require arguments
# TODO: abort if image tag exists or use digest in images
