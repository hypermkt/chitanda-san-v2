# chitanda-san-v2

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
$ bundle exec ruby lib/chitanda-san.rb
```