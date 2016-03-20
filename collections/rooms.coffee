@db.Rooms = new Mongo.Collection "rooms"

# Disable insert, update, and remove on the client.
# Must use meteor methods on server to handle all operations for security purposes.
@db.Rooms.allow
  insert: -> false
  update: -> false
  remove: -> false

@db.Rooms.deny
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

@db.Rooms.attachSchema @UtilSchemas.Timestamps
@db.Rooms.attachSchema RoomsSchema