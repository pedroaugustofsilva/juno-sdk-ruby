FROM ruby:2.7

RUN mkdir /app

ENV GEM_PATH /app/.bundle

COPY . /app

RUN cd /app && bundle install

WORKDIR /app