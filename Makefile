REPOSITORY = tarikihr/node4-lts
TAG = $(n)-$(b)

default: all

all: base onbuild

base: f
	docker build --build-arg NODE_VERSION=$(n) -t $(REPOSITORY):latest .
	docker tag $(REPOSITORY):latest $(REPOSITORY):$(TAG)
	docker push $(REPOSITORY):latest
	docker push $(REPOSITORY):$(TAG)

onbuild: f
	cd onbuild && \
		sed 's/NODE_VERSION/$(TAG)/g' Dockerfile | \
		docker build -t $(REPOSITORY):onbuild -
	docker tag $(REPOSITORY):onbuild $(REPOSITORY):$(TAG)-onbuild
	docker push $(REPOSITORY):onbuild
	docker push $(REPOSITORY):$(TAG)-onbuild

# force/ensure commands get run everytime even though they don't have a target
f: 
