FROM ruby:2.6

Add . /opt/chitanda-san
WORKDIR /opt/chitanda-san

RUN gem install bundler \
 && bundle install --deployment --without development -j4

CMD bundle exec ruby bin/chitanda-san.rb
