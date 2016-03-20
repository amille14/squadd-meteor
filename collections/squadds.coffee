@db.Squadds = new Mongo.Collection "squadds"

@db.Squadds.allow
  insert: -> false
  update: -> false
  remove: -> false

@db.Squadds.deny
  insert: -> true
  update: -> true
  remove: -> true

SquaddsSchema = new SimpleSchema
  #=== ATTRIBUTES ===
  name:
    type: String
    label: "The name of this squadd"
    max: 30

@db.Squadds.attachSchema @UtilSchemas.Timestamps
@db.Squadds.attachSchema SquaddsSchema