# Author: Radim Daniel Pánek <rdpanek@gmail.com>
#
# make build  - build new image from Dockerfile


NAME=rdpanek/jmeter
VERSION=2.13
PARAM=$(filter-out $@,$(MAKECMDGOALS))


default:
	@echo Please use \'make build\'

build:
	docker build -t $(NAME):$(VERSION) .

run:
	docker run --rm $(NAME):$(VERSION) /srv/var/jmeter/apache-jmeter-$(VERSION)/bin/jmeter $(PARAM)

server:
	docker run --rm $(NAME):$(VERSION) /srv/var/jmeter/apache-jmeter-$(VERSION)/bin/jmeter -s $(PARAM)

test:
	rm -rf *.jtl *.log && \
	docker run --rm -v `pwd`:/mnt/test $(NAME):$(VERSION) /srv/var/jmeter/apache-jmeter-$(VERSION)/bin/jmeter -n -t /mnt/test/$(PARAM) -l /mnt/test/$(PARAM).jtl -j /mnt/test/$(PARAM).log


tag:
	git tag -d $(VERSION) 2>&1 > /dev/null
	git tag -d latest 2>&1 > /dev/null
	git tag $(VERSION)
	git tag latest
