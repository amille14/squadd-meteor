Meteor.methods
  insertMessage: (content, roomId) ->
    throw new Meteor.Error("not-authorized") unless Meteor.userId()?

    db.Messages.insert
      content: content
      userId: Meteor.userId()
      roomId: roomId