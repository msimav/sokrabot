# Description:
#   Handy questions and answers
#

kvUrl = "https://#{process.env.KEY_VALUE_DOMAIN}/kv"
kvToken = "Bearer #{process.env.KEY_VALUE_TOKEN}"

module.exports = (robot) ->

  robot.hear /(\w+) (link|url)/i, (res) ->
    key = res.match[1]
    if key
        res.http("#{kvUrl}?key=eq.#{robot.name}-#{key.toLowerCase()}")
        .header('Authorization', kvToken)
        .get() (err, resp, body) ->
          unless err
            value = JSON.parse(body)[0].value
            res.send value

  robot.respond /(\w+) artik (\w+)$/i, (res) ->
    key = res.match[1]
    value = res.match[2]
    if key and value
      request = JSON.stringify
        key: "#{robot.name}-#{key.toLowerCase()}"
        value: value
      res.http(kvUrl)
        .header('Authorization', kvToken)
        .header('Content-Type', 'application/json')
        .post(request) (err, resp, body) ->
          unless err
            res.send "Ok!"


