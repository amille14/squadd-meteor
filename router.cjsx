requireSignIn = (context, redirect) ->
  redirect('/signup') unless Meteor.userId()?

FlowRouter.route '/',
  name: 'app'
  triggersEnter: [requireSignIn]
  action: ->
    ReactLayout.render App

FlowRouter.route '/signup',
  name: 'signup'
  action: ->
    ReactLayout.render SignupPage

roomGroup = FlowRouter.group
  prefix: '/:roomName'
  name: 'room'

roomGroup.route '/',
  action: (params, queryParams) ->
    # TODO:
    # If params.roomName matches an existing room name, render that room
    # Otherwise redirect to general room

roomGroup.route '/posts/:postId',
  action: (params, queryParams) ->
    # TODO:
    # If post with this id exists within this room, render post
    # Otherwise redirect to room
