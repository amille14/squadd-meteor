Messages = require("../../messages/messages").Messages
Users    = require("../../users/users").Users

Meteor.publishComposite "messages", (roomId) ->
  find: ->
    Messages.find {roomId: roomId}, Messages.publicFields

  # Users
  children: [
    find: (message) -> Users.find _id: message.userId
  ]