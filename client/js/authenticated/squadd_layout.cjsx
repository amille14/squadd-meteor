{ createContainer } = require("meteor/react-meteor-data")
{ SubsManager } = require("meteor/meteorhacks:subs-manager")
Messages = require("../../../imports/api/messages/messages").Messages
Rooms = require("../../../imports/api/rooms/rooms").Rooms

class SquaddLayout extends React.Component
  render: ->
    <div id="squadd-layout">
      { if @props.loading
          <Loader style={fontSize: 12}/>
        else
          <div>
            <SideNav />
          </div>
      }
    </div>

# Create subscription manager
SquaddSubsManager = new SubsManager()

# Create data container and fetch data
@SquaddLayout = createContainer ((props) =>
  # TODO: Fetch the whole squadd, not just the room and messages

  roomId = Session.get("currentRoomId")
  handle = SquaddSubsManager.subscribe("room", roomId)

  room = Rooms.find({_id: roomId})
  messages = Messages.find({roomId: roomId}, {sort: {createdAt: 1}})

  return {
    loading: !handle.ready()
    room: room.fetch()
    messages: messages.fetch()
  }

), SquaddLayout

