{ mount } = require("react-mounter")

#=== AUTHENTICATED ROUTES ===

# Create the authenticated routes group.
# These routes will automatically redirect to the login page if the user is not logged in.
# After logging in, user should be redirected back to their original destination.
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
    # TODO: These are temprorary testing variables and should be changed to whatever the current squadd and room ids are.
    Session.set "currentSquaddId", "AyyA2C6RSMiqAoLFq"
    Session.set "currentRoomId", "qqaw6qMm9oJ7352o2"
    
    mount App, yield: <ChatLayout />
