Meteor.publishComposite "roomMessages", (roomId) ->
  find: -> db.Rooms.find({_id: roomId}, {limit: 1})

  # Messages
  children: [
    find: (room) -> db.Messages.find({roomId: room._id}, {sort: {createdAt: 1}})

    # Users
    children: [
      find: (message, room) -> Meteor.users.find({_id: message.userId}, {limit: 1})
    ]
  ]