# Description:
#   JIRA related functionality
#

jiraDomain = process.env.JIRA_DOMAIN
jiraUser = process.env.JIRA_USERNAME
jiraPass = process.env.JIRA_PASSWORD

module.exports = (robot) ->

  robot.hear /EN-(\d{2,5})/i, (res) ->
    issueNumber = res.match[1]
    issueUrl = "https://" + jiraDomain + "/browse/EN-" + issueNumber
    res.reply issueUrl
    apiUrl = "https://" + jiraDomain + "/rest/api/latest/issue/EN-" + issueNumber
    res.http(apiUrl).auth(jiraUser, jiraPass).get() (err, resp, body) ->
      unless err
        summary = JSON.parse(body).fields.summary
        res.reply summary
