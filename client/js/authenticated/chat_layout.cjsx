{ createContainer } = require("meteor/react-meteor-data")
{ SubsManager } = require("meteor/meteorhacks:subs-manager")
Messages = require("../../../imports/api/messages/messages").Messages
Rooms = require("../../../imports/api/rooms/rooms").Rooms

class ChatLayout extends React.Component
  render: ->
    <div id="chat-layout">
      { if @props.loading
          <div className="page-loader-container">
            <Loader style={fontSize: 18}/>
          </div>
        else
          <div>
            <SideNav />
            <Chat messages={@props.messages} room={@props.room} />
          </div>
      }
    </div>

# Create subscription manager
SquaddSubsManager = new SubsManager()

# Create data container and fetch data
@ChatLayout = createContainer ((props) =>
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

), ChatLayout

