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

  # Configure browser policy
  # TODO: Add back the browser-policy package
  # BrowserPolicy.content.allowFontOrigin "fonts.googleapis.com"
  # BrowserPolicy.content.allowStyleOrigin "fonts.googleapis.com"

  # Configure Kadira
  Kadira.connect Meteor.settings.KADIRA_APP_ID, Meteor.settings.KADIRA_APP_SECRET

  # Configure Mailgun
  process.env.MAIL_URL = "smtp://postmaster%40" + Meteor.settings.MAILGUN_EMAIL + ":" + Meteor.settings.MAILGUN_PASSWORD + "@smtp.mailgun.org:587"