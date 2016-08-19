{ mount } = require("react-mounter")

#=== PUBLIC ROUTES ===
publicRoutes = FlowRouter.group(name: 'public')

publicRoutes.route '/login',
  name: 'login'
  triggersEnter: [(context, redirect) ->
    redirect('app') if Meteor.userId()
  ]
  action: ->
    mount App, yield: <Signin />

publicRoutes.route '/signup',
  name: 'signup'
  action: ->
    mount App, yield: <Signup />

publicRoutes.route '/logout',
  name: 'logout'
  action: ->
    Meteor.logout ->
      FlowRouter.go FlowRouter.path('login')



#=== OTHER ===
FlowRouter.notFound =
  action: ->
    mount App, yield: <NotFound404 />