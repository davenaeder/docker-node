REPOSITORY = iheartradio/node
TAG = $(n)-$(b)
GIT_TAG = v$(TAG)
BASE_IMAGE = $(REPOSITORY):$(TAG)
ONBUILD_IMAGE = $(BASE_IMAGE)-onbuild

default: all

build: base-build onbuild-build

all: tag base onbuild badges

tag:
	git tag $(GIT_TAG)
	git push origin $(GIT_TAG)

base-build:
	docker build --build-arg NODE_VERSION=$(n) -t $(BASE_IMAGE) .

base: base-build
	docker push $(BASE_IMAGE)

onbuild-build: base-build
	cd onbuild && \
		sed 's/NODE_VERSION/$(TAG)/g' Dockerfile | \
		docker build -t $(ONBUILD_IMAGE) -

onbuild: onbuild-build
	docker push $(ONBUILD_IMAGE)

badges: LATEST_TAG = $(REPOSITORY):latest
badges:
	# tag 'latest'
	docker tag $(BASE_IMAGE) $(LATEST_TAG)
	docker push $(LATEST_TAG)
	# webhook notify
	curl -X POST https://hooks.microbadger.com/images/iheartradio/node/AMUBttS2FxPHZQFvE8mlwagfCig=

.PHONY: all build base-build base onbuild-build onbuild badges

# TODO: require arguments
# TODO: abort if image tag exists or use digest in images
