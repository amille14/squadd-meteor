Rooms = require("../rooms")
Messages = require("../../messages/messages")
Users = require("../../users/users")

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