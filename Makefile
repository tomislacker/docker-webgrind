IMAGE_REPO := webgrind
IMAGE_TAG := latest
IMAGE := $(IMAGE_REPO):$(IMAGE_TAG)

# Default cachegrind output dir
PERF_DIR := $(shell readlink -m perf)

.PHONY: container
container:
	docker build \
		--quiet \
		-t $(IMAGE) \
		.

.PHONY: webgrind
webgrind: container
	docker run \
		-it \
		--rm \
		-p 8090:80 \
		-v $(PERF_DIR):/cachegrind \
		$(IMAGE)
