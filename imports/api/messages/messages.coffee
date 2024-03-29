SharedSchemas = require("../shared_schemas")
Users = require("../users/users").Users
Rooms = require("../rooms/rooms").Rooms
Posts = require("../posts/posts").Posts

class MessagesCollection extends Mongo.Collection
Messages = exports.Messages = new MessagesCollection "Messages"

unless Meteor.settings.public.ENV in ["development", "staging"]
  Messages.allow
    insert: -> false
    update: -> false
    remove: -> false

  Messages.deny
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

Messages.publicFields = 
  userId: 1
  roomId: 1
  postId: 1
  content: 1

Messages.attachSchema SharedSchemas.Timestamps
Messages.attachSchema MessagesSchema


#=== HELPERS ===
Messages.helpers
  user: -> Users.find _id: @userId
  room: -> Rooms.find _id: @roomId
  post: -> Posts.find _id: @postId