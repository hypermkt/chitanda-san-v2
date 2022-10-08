FROM ruby:3.1

Add . /opt/chitanda-san
WORKDIR /opt/chitanda-san

RUN bundle config set without development \
 && bundle install -j4

CMD bundle exec ruby bin/chitanda-san.rb
