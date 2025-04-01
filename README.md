# Ruboty::SlackEvents

Slack ([Events API](https://api.slack.com/apis/events-api)) adapter for [Ruboty](https://github.com/r7kamura/ruboty).

## Installation

```ruby
gem 'ruboty-slack_events'
```

### Configure Slack App

This gem uses [Slack Events API](https://api.slack.com/apis/events-api) and its [Socket mode](https://api.slack.com/apis/socket-mode) to receive events from Slack.

1. Create a Slack App at [Slack API](https://api.slack.com/apps) with the following App manifest.
2. Generate an app-level token with `connections:write` scope from your App's Basic Information settings.

<details><summary>App manifest</summary>

(Rewrite `Demo App` to your app name)

```yaml
_metadata:
  major_version: 1
display_information:
  name: Demo App
features:
  bot_user:
    display_name: Demo App
    always_online: false
oauth_config:
  scopes:
    bot:
      - channels:history
      - users:read
      - chat:write
settings:
  event_subscriptions:
    bot_events:
      - message.channels
  interactivity:
    is_enabled: true
  org_deploy_enabled: false
  socket_mode_enabled: true
  token_rotation_enabled: false
```

</details>

For details of configurations for Socket Mode, see: https://api.slack.com/apis/socket-mode.

### ENV

- `SLACK_TOKEN`: Bot token of your Slack App.
- `SLACK_APP_TOKEN`: App-level token of your Slack App.
- `SLACK_IGNORE_BOT_MESSAGE`: If this has truthy value, bot ignores messages by bots (optional)
- `SLACK_AUTO_RECONNECT`: If this has truthy value, reconnect websocket automatically (optional)

For details of token types, See: https://api.slack.com/concepts/token-types

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tomoasleep/ruboty-slack_events. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/tomoasleep/ruboty-slack_events/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ruboty::SlackEvents project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tomoasleep/ruboty-slack_events/blob/main/CODE_OF_CONDUCT.md).
