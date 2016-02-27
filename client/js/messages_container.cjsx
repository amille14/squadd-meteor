

@MessagesContainer = React.createClass
  mixins: [ReactMeteorData]

  getInitialState: ->
    # marginBottom - the margin-bottom css style
    # scrollTo - the percentage down the page we should scroll to on next update
    {marginBottom: 69, scrollTo: 100}

  getMeteorData: ->
    return {
      messages: db.messages.find({}).fetch()
    }

  componentDidMount: ->
    @_scrollToBottom()

  componentDidUpdate: ->
    @_scrollTo()

  shouldComponentUpdate: (nextProps, nextState) ->
    @state.marginBottom isnt nextState.marginBottom or
    @state.scrollTo isnt nextState.scrollTo

  render: ->
    props =
      style:
        marginBottom: @state.marginBottom

    <div id="messages-container" ref="messagesContainer" {...props}>
      <div id="messages">{@_renderMessages()}</div>
      <MessageInput parent={@} />
    </div>

  _scrollTo: ->
    $(@refs.messagesContainer).scrollTop (@state.scrollTo / 100) * @_getScrollHeight()

  _scrollToBottom: ->
    $(@refs.messagesContainer).scrollTop @_getScrollHeight()

  _updateMarginBottom: (bottom, reset = false) ->
    if reset
      @setState @getInitialState
    else
      @setState(marginBottom: bottom, scrollTo: @_getScrollPercentage())

  _renderMessages: ->
    @data.messages.map (message) =>
      <TransitionFlashBG key={message._id}>
        <Message key={message._id} text={message.text} time={message.createdAt} />
      </TransitionFlashBG>

  _getScrollHeight: -> $(@refs.messagesContainer).prop("scrollHeight")
  _getScrollPercentage: -> $(@refs.messagesContainer).scrollTop() / @_getScrollHeight() * 100