Squadds = new Mongo.Collection "squadds"

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

Squadds.attachSchema @UtilSchemas.Timestamps
Squadds.attachSchema SquaddsSchema