NAME=devtransition/jmeter-remote-sshd
VERSION=2.13-1.3.1
PARAM=$(filter-out $@,$(MAKECMDGOALS))


default:
	@echo Please use \'make build\'

build:
	docker build -t $(NAME):$(VERSION) .

build-clean:
	docker build -t $(NAME):$(VERSION) --force-rm --no-cache .

run:
	docker run --rm $(NAME):$(VERSION) $(PARAM)

tag:
	git tag -d $(VERSION) 2>&1 > /dev/null
	git tag -d latest 2>&1 > /dev/null
	git tag $(VERSION)
	git tag latest
