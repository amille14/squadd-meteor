#=== METHODS ===
requireLogIn = (context, redirect) ->
  redirect('/signup') unless Meteor.userId()?



#=== PUBLIC ROUTES ===
publicRoutes = FlowRouter.group(name: 'public')

publicRoutes.route '/login',
  name: 'login'
  action: ->
    ReactLayout.render App, yield: <LoginCard />

publicRoutes.route '/signup',
  name: 'signup'
  action: ->
    ReactLayout.render App, yield: <SignupCard />



#=== AUTHENTICATED ROUTES ===
authenticatedRoutes = FlowRouter.group(name: 'authenticated')

authenticatedRoutes.route '/',
  name: 'app'
  triggersEnter: [requireLogIn]
  action: ->
    ReactLayout.render App, yield: <ChatLayout />



#=== HELPERS ===
pathFor = (path, params) =>
  query = if params and params.query then FlowRouter._qs.parse(params.query) else {}
  return FlowRouter.path(path, params, query)

urlFor = (path, params) =>
  return Meteor.absoluteUrl pathFor(path, params)

@FlowHelpers =
  pathFor: pathFor
  urlFor: urlFor