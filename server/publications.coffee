Meteor.publish "room", (roomId) =>

  #TODO: Fetch a specific room and its messages based on roomId

  console.log "PUBLISH"

  return @db.Messages.find({}, {sort: {createdAt: 1}})