# chitanda-san-v2 [![CircleCI](https://circleci.com/gh/hypermkt/chitanda-san-v2.svg?style=svg)](https://circleci.com/gh/hypermkt/chitanda-san-v2)

Notify today's anime tv programs.

## Setup

```sh
$ export SLACK_INCOMING_WEBHOOK_URL=#{https://...}
$ export SLACK_CHANNEL=#anime
$ export SLACK_USERNAME=千反田える
$ export SLACK_ICON_EMOJI=:erutaso:
```

```sh
$ bundle install --path vendor/bundle
```

## Execute

```sh
$ bundle exec ruby bin/chitanda-san.rb
```
