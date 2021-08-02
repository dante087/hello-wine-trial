FROM ruby:2.7.2-alpine

# Postgres and Nokogiri's build dependencies
RUN apk add --update build-base libxml2-dev libxslt-dev postgresql-dev tzdata

RUN mkdir /hello-wine-trial
WORKDIR /hello-wine-trial
COPY Gemfile /hello-wine-trial/Gemfile
COPY Gemfile.lock /hello-wine-trial/Gemfile.lock
RUN bundle install
COPY . /hello-wine-trial

EXPOSE 3000
CMD ["bin/start"]