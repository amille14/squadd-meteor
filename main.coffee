Meteor.startup =>

  if Meteor.isClient
    # Set up global database variable for use in dev environment
    if Meteor.settings.ENV in ["development", "staging"]
      @db = {}
      @db.Messages = require("./imports/api/messages/messages")
      @db.Posts    = require("./imports/api/posts/posts")
      @db.Users    = require("./imports/api/users/users")
      @db.Rooms    = require("./imports/api/rooms/rooms")
      @db.Squadds  = require("./imports/api/squadds/squadds")