IMAGE_REPO := webgrind
IMAGE_TAG := latest
IMAGE := $(IMAGE_REPO):$(IMAGE_TAG)

# Default cachegrind output dir
PERF_DIR := perf

# Default listening port
PORT := 8090

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
		-p $(PORT):80 \
		-v $(shell readlink -m $(PERF_DIR)):/cachegrind \
		$(IMAGE)
