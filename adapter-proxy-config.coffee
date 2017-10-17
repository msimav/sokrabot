ourGroup = process.env.TELEGRAM_CHAT_ID

class MyProxyConfig
  adapter: "telegram"

  events:
    shouldSend: (adapter, envelope) ->
      console.log envelope
      envelope.room == ourGroup  # Only send messages to our telegram chat

module.exports = MyProxyConfig