REPOSITORY = iheartradio/node
TAG = $(n)-$(b)
BASE_IMAGE = $(REPOSITORY):$(TAG)

default: all

all: base onbuild badges

base:
	docker build --build-arg NODE_VERSION=$(n) -t $(BASE_IMAGE) .
	docker push $(BASE_IMAGE)

onbuild: ONBUILD_IMAGE = $(BASE_IMAGE)-onbuild
onbuild: base
	cd onbuild && \
		sed 's/NODE_VERSION/$(TAG)/g' Dockerfile | \
		docker build -t $(ONBUILD_IMAGE) -
	docker push $(ONBUILD_IMAGE)

badges: LATEST_TAG = $(REPOSITORY):latest
badges:
	# tag 'latest'
	docker tag $(BASE_IMAGE) $(LATEST_TAG)
	docker push $(LATEST_TAG)
	# webhook notify
	curl -X POST https://hooks.microbadger.com/images/iheartradio/node/AMUBttS2FxPHZQFvE8mlwagfCig=

.PHONY: all base onbuild badges

# TODO: require arguments
# TODO: abort if image tag exists or use digest in images
