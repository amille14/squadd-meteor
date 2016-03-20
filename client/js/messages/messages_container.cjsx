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
      <Messages ref="messages" />
      <MessageInput parent={@} />
    </div>



#=== MESSAGES ====
@Messages = React.createClass
  mixins: [ReactMeteorData]

  getInitialState: ->
    shouldScrollBottom: true

  getMeteorData: ->
    subHandle = Meteor.subscribe("room", "someID") #TODO: Subscribe to a particular room id
    messages = db.Messages.find({}, {sort: {createdAt: 1}})

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
      component =
        <TransitionFlashBG key={message._id}>
          { <DateDivider date={message.createdAt} /> if prev? and !moment(prev.createdAt).isSame(moment(message.createdAt), 'day') }
          <Message key={message._id} message={message} prevMessage={prev} />
        </TransitionFlashBG>

      prev = message
      return component

  render: ->
    console.log "RENDERED MESSAGES"
    <div id="messages" ref="messages">{@_renderMessages()}</div>

