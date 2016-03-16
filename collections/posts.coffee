Posts = new Mongo.Collection "posts"

Posts.allow
  insert: -> false
  update: -> false
  remove: -> false

Posts.deny
  insert: -> true
  update: -> true
  remove: -> true

PostsSchema = new SimpleSchema
  #=== ASSOCIATIONS ===
  userId:
    type: String
    label: "The id of the user who wrote this post"
  roomId:
    type: String
    label: "The id of the room this post belongs to"

  #=== ATTRIBUTES ===
  type:
    type: String
    label: "The type of this post"
    allowedValues: ["text", "link", "image", "video", "vote"]
  title:
    type: String
    label: "The title of this post"
    max: 300
  content:
    type: String
    label: "The content of this post"
    max: 40000
  url:
    type: String
    label: "The url of this post"
    max: 10000
    regEx: SimpleSchema.RegEx.Domain
  cred:
    type: Number
    label: "How much cred this post has earned"
    min: 0
    defaultValue: 0
  privateFor:
    type: [String]
    label: "A list of user ids who can view this post"
    optional: true

Posts.attachSchema @UtilSchemas.Timestamps
Posts.attachSchema PostsSchema