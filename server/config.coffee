fontRegExp = /\.(eot|ttf|otf|woff|woff2)$/
WebApp.rawConnectHandlers.use '/', (req, res, next) ->
  if fontRegExp.test(req._parsedUrl.pathname)
    res.setHeader 'Access-Control-Allow-Origin', '*'
    res.setHeader 'Vary', 'Origin'
    res.setHeader 'Pragma', 'public'
    res.setHeader 'Cache-Control', '"public"'
  next()