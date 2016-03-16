#=== PUBLIC ROUTES ===
publicRoutes = FlowRouter.group(name: 'public')

publicRoutes.route '/login',
  name: 'login'
  triggersEnter: [(context, redirect) ->
    redirect('app') if Meteor.userId()
  ]
  action: ->
    ReactLayout.render App, yield: <LoginCard />

publicRoutes.route '/signup',
  name: 'signup'
  action: ->
    ReactLayout.render App, yield: <SignupCard />

publicRoutes.route '/logout',
  name: 'logout'
  action: ->
    Meteor.logout ->
      FlowRouter.go FlowRouter.path('login')


#=== AUTHENTICATED ROUTES ===
authenticatedRoutes = FlowRouter.group
  name: 'authenticated'
  triggersEnter: [(context, redirect) ->
    unless Meteor.loggingIn() or Meteor.userId()
      current = FlowRouter.current()

      # Save the route the user wanted to go to and redirect there after they log in
      Session.set 'redirectAfterLogin', current.path unless current.route.name in ['login', 'signup', 'logout']
      FlowRouter.go 'login'
  ]

authenticatedRoutes.route '/',
  name: 'app'
  action: ->
    ReactLayout.render App, yield: <ChatLayout />


#=== 404 NOT FOUND ===
FlowRouter.notFound =
  action: ->
    ReactLayout.render App, yield: <NotFound404 />


#=== HELPERS ===
pathFor = (path, params) =>
  query = if params and params.query then FlowRouter._qs.parse(params.query) else {}
  return FlowRouter.path(path, params, query)

urlFor = (path, params) =>
  return Meteor.absoluteUrl pathFor(path, params)

@FlowHelpers =
  pathFor: pathFor
  urlFor: urlFor