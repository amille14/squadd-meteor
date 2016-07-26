# require("es6-shim")

# Require collections so they can be queried in dev/staging console
if Meteor.settings.public.ENV in ['development', 'staging']
  @db = {}
  @db.Messages = require("../imports/api/messages/messages").Messages
  @db.Posts    = require("../imports/api/posts/posts").Posts
  @db.Users    = require("../imports/api/users/users").Users
  @db.Rooms    = require("../imports/api/rooms/rooms").Rooms
  @db.Squadds  = require("../imports/api/squadds/squadds").Squadds