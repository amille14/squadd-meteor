SharedSchemas = require("../shared_schemas")
Users = require("../users/users")
Squadds = require("../squadds/squadds")
Messages = require("../messages/messages")

class RoomsCollection extends Mongo.Collection
Rooms = exports.Rooms = new RoomsCollection "Rooms"

# Disable insert, update, and remove on the client.
# Must use meteor methods on server to handle all operations for security purposes.
Rooms.allow
  insert: -> false
  update: -> false
  remove: -> false
Rooms.deny
  insert: -> true
  update: -> true
  remove: -> true

RoomsSchema = new SimpleSchema
  #=== ASSOCIATIONS ===
  userId:
    type: String
    label: "The id of the user this room belongs to"
    optional: true
  squaddId:
    type: String
    label: "The id of the squadd this room belongs to"
    optional: true

  #=== ATTRIBUTES ===
  name:
    type: String
    label: "The name of this room"
    max: 30
  description:
    type: String
    label: "The description of this room"
    max: 140
    optional: true

Rooms.publicFields = 
  userId: 1
  squaddId: 1
  name: 1
  description: 1

Rooms.attachSchema SharedSchemas.Timestamps
Rooms.attachSchema RoomsSchema

#=== HELPERS ===
Rooms.helpers
  user: -> Users.findOne @userId
  squadd: -> Squadds.findOne @squaddId
  messages: -> Messages.find {roomId: @_id}, {sort: {createdAt: 1}}

module.exports = Rooms