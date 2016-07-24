Messages = require("./messages")

Meteor.methods
  'messages.insert': (content, roomId) ->
    throw new Meteor.Error("not-authorized") unless Meteor.userId()?

    Messages.insert
      content: content
      userId: Meteor.userId()
      roomId: roomId