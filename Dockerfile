FROM rubylang/ruby:3.0.0-focal

Add . /opt/chitanda-san
WORKDIR /opt/chitanda-san

RUN gem install bundler\
 && bundle config set deployment 'true'\
 && bundle config set without 'development'\
 && bundle install -j4

CMD bundle exec ruby bin/chitanda-san.rb
