Users = require("./users").Users


# TODO: This is unsafe?
# Meteor.methods
  # 'users.update': (userId, fields) ->
  #   throw new Meteor.Error("not-authorized") unless Meteor.userId()? and Meteor.userId() is userId

  #   Users.update { _id: userId }, { $set: fields }