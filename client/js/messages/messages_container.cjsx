@MessagesContainer = React.createClass
  # mixins: [ReactMeteorData]

  # getInitialState: ->
  #   # marginBottom - the margin-bottom css style
  #   # scrollTo - the percentage down the page we should scroll to on next update
  #   {marginBottom: 69, scrollToBottom: true}

  # componentDidMount: ->
  #   @_scrollToBottom()

  # componentWillUpdate: (nextProps, nextState) ->
  #   $el = $(@refs.messagesContainer)
  #   @shouldScrollBottom = ($el.scrollTop() + $el.prop('offsetHeight') is @_getScrollHeight()) or nextState.scrollToBottom
  #   @setState(scrollToBottom: false)

  # componentDidUpdate: ->
  #   if @shouldScrollBottom
  #     @_scrollToBottom()

  # shouldComponentUpdate: (nextProps, nextState) ->
  #   @state.marginBottom isnt nextState.marginBottom or
  #   @state.scrollToBottom isnt nextState.scrollToBottom

  # _scrollToBottom: ->
  #   $(@refs.messagesContainer).scrollTop @_getScrollHeight()

  # _updateMarginBottom: (bottom, reset=false) ->
  #   if reset
  #     @setState @getInitialState()
  #   else
  #     @setState(marginBottom: bottom, scrollToBottom: false)

  # _getScrollHeight: -> $(@refs.messagesContainer).prop("scrollHeight")



  getInitialState: ->
    marginBottom: 69

  setMarginBottom: (marginBottom) ->
    @setState marginBottom: marginBottom
    $(@refs.messagesContainer).css "margin-bottom": marginBottom

  scrollToBottom: ->
    console.log "SCROLL TO BOTTOM", $(@refs.messagesContainer).prop("scrollHeight")
    $(@refs.messagesContainer).scrollTop $(@refs.messagesContainer).prop("scrollHeight")

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

  # getInitialState: ->
  #   shouldScrollBottom: true

  getMeteorData: ->
    messages = db.messages.find({}, {sort: {createdAt: 1}})

    return {
      messages: messages.fetch()
    }


  # #=== LIFECYCLE ===
  # componentWillUpdate: (np, ns) ->
  #   $el = $(@refs.messages)
  #   @shouldScrollBottom = $el.scrollTop() + $el.prop("offsetHeight") is @_getScrollHeight() or nextState.shouldScrollBottom
  #   @setState(shouldScrollBottom: false)

  # componentDidUpdate: ->
  #   @_scrollToBottom() if @shouldScrollBottom

  # _scrollToBottom: ->
  #   $(@refs.messages).scrollTop @_getScrollHeight()

  # _getScrollHeight: -> $(@refs.messages).prop("scrollHeight")


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
    console.log "RENDER MESSAGES"
    <div id="messages" ref="messages">{@_renderMessages()}</div>

