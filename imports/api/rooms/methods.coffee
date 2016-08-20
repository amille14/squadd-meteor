{ Rooms } = require("./rooms")

Meteor.methods
  'rooms.insert': (name, description, squaddId, userId) ->
    throw new Meteor.Error("not-authorized") unless Meteor.userId()?

    Rooms.insert
      name: name
      description: description
      userId: userId
      squaddId: squaddId