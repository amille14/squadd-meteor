Rooms = require("../rooms").Rooms
Messages = require("../../messages/messages").Messages
Users = require("../../users/users").Users

Meteor.publishComposite "room", (roomId) ->
  find: -> Rooms.findOne {_id: roomId}, Rooms.publicFields

  # Messages
  children: [
    find: (room) -> room.messages

    # Users
    children: [
      find: (message, room) -> message.user
    ]
  ]