# Messages = require("../../../imports/api/messages/messages").Messages

@MessagesContainer = React.createClass
  getInitialState: ->
    marginBottom: 69

  setMarginBottom: (marginBottom) ->
    @setState marginBottom: marginBottom
    $(@refs.messagesContainer).css "margin-bottom": marginBottom

  shouldComponentUpdate: (nextProps, nextState) ->
    !_.isEqual(@props, nextProps)

  render: ->
    console.log "RENDERED CONTAINER"
    props =
      style:
        marginBottom: @state.marginBottom

    <div id="messages-container" ref="messagesContainer" {...props}>
      <RoomMessages ref="messages" />
      <MessageInput parent={@} />
    </div>



#=== MESSAGES ===
RoomSub = new SubsManager()
@RoomMessages = React.createClass
  mixins: [ReactMeteorData]

  getInitialState: ->
    shouldScrollBottom: true

  getMeteorData: ->
    subHandle = RoomSub.subscribe("room", Session.get("currentRoomId"))
    messages = Messages.find({roomId: Session.get("currentRoomId")}, {sort: {createdAt: 1}})

    return {
      ready: subHandle.ready()
      messages: messages.fetch()
    }


  #=== LIFECYCLE ===
  componentDidMount: ->
    @_scrollToBottom()

  shouldComponentUpdate: (np, ns) ->
    @state.shouldScrollBottom isnt ns.shouldScrollBottom and ns.shouldScrollBottom is true

  componentWillUpdate: (np, ns) ->
    $el = $(@refs.messages)
    @shouldScrollBottom = @_getScrollHeight() - ($el.scrollTop() + $el.prop("offsetHeight")) <= 25 or ns.shouldScrollBottom

  componentDidUpdate: ->
    @_scrollToBottom() if @shouldScrollBottom
    @setState(shouldScrollBottom: false)

  _scrollToBottom: ->
    $(@refs.messages).scrollTop @_getScrollHeight()

  _getScrollHeight: -> $(@refs.messages).prop("scrollHeight")


  #=== RENDERING ===
  _renderMessages: ->
    prev = null
    @data.messages.map (message) =>
      message.user = @_getUser(message)
      component =
        <TransitionFlashBG key={message._id}>
          { <DateDivider date={message.createdAt} /> if prev? and !moment(prev.createdAt).isSame(moment(message.createdAt), 'day') }
          <Message key={message._id} message={message} prevMessage={prev} />
        </TransitionFlashBG>

      prev = message
      return component

  _getUser: (message) ->
    Meteor.users.findOne({_id: message.userId})

  render: ->
    console.log "RENDERED MESSAGES"
    <div id="messages" ref="messages">{@_renderMessages()}</div>

