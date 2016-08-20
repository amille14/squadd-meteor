{ Squadds } = require("./squadds")

Meteor.methods
  'squadds.insert': (name) ->
    throw new Meteor.Error("not-authorized") unless Meteor.userId()?

    Squadds.insert
      name: name