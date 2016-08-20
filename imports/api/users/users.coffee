SharedSchemas = require("../shared_schemas")
Messages = require("../messages/messages").Messages
Squadds = require("../squadds/squadds").Squadds
Rooms = require("../rooms/rooms").Rooms

unless Meteor.settings.public.ENV in ["development", "staging"]
  Meteor.users.allow
    insert: -> false
    update: -> false
    remove: -> false

  Meteor.users.deny
    insert: -> true
    update: -> true
    remove: -> true

Schema = {}

Schema.UserCountry = new SimpleSchema
  name:
    type: String
  code:
    type: String
    regEx: /^[A-Z]{2}$/

Schema.UserProfile = new SimpleSchema
  firstName:
    type: String
    optional: true
    max: 20
  lastName:
    type: String
    optional: true
    max: 20
  gender:
    type: String
    allowedValues: ['male', 'female']
    optional: true
  bio:
    type: String
    optional: true
  country:
    type: Schema.UserCountry
    optional: true

Schema.UserSquadd = new SimpleSchema
  squaddId:
    type: String
    label: "The id of this squadd"
  title:
    type: String
    label: "The users's title for this squadd"
    max: 30
    optional: true
  permissions:
    type: Number
    label: "The users's permission level for this squadd"
    defaultValue: 0
    min: 0
    max: 4
  cred:
    type: Number
    label: "The user's cred for this squadd"
    defaultValue: 0
    min: 0

Schema.User = new SimpleSchema
  #=== ASSOCIATIONS ===
  roomId:
    type: String
    label: "The id of the room that belongs to this user"
    optional: true # TODO: Change this to auto-create a new room when a user is created
  squadds:
    type: [Schema.UserSquadd]
    label: "The list of squadds this user belongs to"
    optional: true

  #=== ATTRIBUTES ===
  username:
    type: String
    regEx: /^[a-z]{1}[a-z0-9]+$/i  # Lowercase letters and numbers only
    min: 3
    max: 30
  emails:
    type: Array
    optional: true
  'emails.$':
    type: Object
  'emails.$.address':
    type: String
    regEx: SimpleSchema.RegEx.Email
  'emails.$.verified':
    type: Boolean
  registered_emails:
    type: [ Object ]
    optional: true
    blackbox: true
  profile:
    type: Schema.UserProfile
    optional: true
  services:
    type: Object
    optional: true
    blackbox: true
  roles:
    type: Object
    optional: true
    blackbox: true
  heartbeat:
    type: Date
    optional: true

Meteor.users.publicFields =
  username: 1
  profile: 1
  squadds: 1

Meteor.users.attachSchema SharedSchemas.Timestamps
Meteor.users.attachSchema Schema.User

#=== HELPERS ===
Meteor.users.helpers
  messages: -> Messages.find {userId: @_id}, {sort: {createdAt: 1}}
  squadds: -> Squadds.find {_id: {$in: _.map(@squadds, "squaddId") }}
  room: -> Rooms.find _id: @roomId

exports.Users = Meteor.users