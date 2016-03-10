Meteor.startup ->

  # Configure fonts to load without CORS issues
  fontRegExp = /\.(eot|ttf|otf|woff|woff2)$/
  WebApp.rawConnectHandlers.use '/', (req, res, next) ->
    if fontRegExp.test(req._parsedUrl.pathname)
      res.setHeader 'Access-Control-Allow-Origin', '*'
      res.setHeader 'Vary', 'Origin'
      res.setHeader 'Pragma', 'public'
      res.setHeader 'Cache-Control', '"public"'
    next()

  # Configure Kadira
  Kadira.connect Meteor.settings.KADIRA_APP_ID, Meteor.settings.KADIRA_APP_SECRET

  # Configure Mailgun
  process.env.MAIL_URL = "smtp://postmaster@" + Meteor.settings.MAILGUN_EMAIL + ".mailgun.org:password@smtp.mailgun.org:" + Meteor.settings.MAILGUN_PASSWORD