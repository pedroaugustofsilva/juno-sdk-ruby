.PHONY: test 

build:
	@docker build . -t juno-sdk-ruby:latest

test:
	@docker run --rm -v $(PWD):/app juno-sdk-ruby rake test
