SharedSchemas = require("../shared_schemas")
Users = require("../users/users").Users
Rooms = require("../rooms/rooms").Rooms

class SquaddsCollection extends Mongo.Collection
Squadds = exports.Squadds = new SquaddsCollection "Squadds"

unless Meteor.settings.public.ENV in ["development", "staging"]
  Squadds.allow
    insert: -> false
    update: -> false
    remove: -> false
  Squadds.deny
    insert: -> true
    update: -> true
    remove: -> true

SquaddsSchema = new SimpleSchema
  #=== ATTRIBUTES ===
  name:
    type: String
    label: "The name of this squadd"
    max: 30

Squadds.publicFields = 
  name: 1

Squadds.attachSchema SharedSchemas.Timestamps
Squadds.attachSchema SquaddsSchema

#=== HELPERS ===
Squadds.helpers
  users: -> Users.find {'squadds.squaddId': @_id}
  rooms: -> Rooms.find {squaddId: @_id}