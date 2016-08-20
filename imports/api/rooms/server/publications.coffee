Rooms    = require("../../rooms/rooms").Rooms
Messages = require("../../messages/messages").Messages
Users    = require("../../users/users").Users

Meteor.publishComposite "room", (roomId) ->
  find: ->
    Rooms.find {_id: roomId}, Rooms.publicFields

  # Messages
  children: [
    find: (room) ->
      Messages.find {roomId: room._id}, {sort: {createdAt: 1}}

    # Users
    children: [
      find: (message, room) -> Users.find _id: message.userId
    ]
  ]