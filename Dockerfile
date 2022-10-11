FROM ruby:3.1

Add . /opt/chitanda-san
WORKDIR /opt/chitanda-san

RUN apt-get update && apt-get upgrade -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && gem update --system \
 && bundle config set without development \
 && bundle install -j4

CMD bundle exec ruby bin/chitanda-san.rb
