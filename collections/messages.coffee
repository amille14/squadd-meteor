@db.Messages = new Mongo.Collection "messages"

@db.Messages.allow
  insert: -> false
  update: -> false
  remove: -> false

@db.Messages.deny
  insert: -> true
  update: -> true
  remove: -> true

MessagesSchema = new SimpleSchema
  #=== ASSOCIATIONS ===
  userId:
    type: String
    label: "The id of the user who wrote this message"
  roomId:
    type: String
    label: "The id of the room this message belongs to"
  postId:
    type: String
    label: "The id of the post this message belongs to"
    optional: true

  #=== ATTRIBUTES ===
  content:
    type: String
    label: "The content of this message"
    max: 5000

@db.Messages.attachSchema @UtilSchemas.Timestamps
@db.Messages.attachSchema MessagesSchema