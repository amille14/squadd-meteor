@MessagesContainer = React.createClass
  mixins: [ReactMeteorData]

  getInitialState: ->
    # marginBottom - the margin-bottom css style
    # scrollTo - the percentage down the page we should scroll to on next update
    {marginBottom: 69, scrollToBottom: true}

  getMeteorData: ->
    return {
      messages: db.messages.find({}).fetch()
    }

  componentDidMount: ->
    @_scrollToBottom()


  componentWillUpdate: (nextProps, nextState) ->
    $el = $(@refs.messagesContainer)
    @shouldScrollBottom = ($el.scrollTop() + $el.prop('offsetHeight') is @_getScrollHeight()) or nextState.scrollToBottom
    @setState(scrollToBottom: false)

  componentDidUpdate: ->
    if @shouldScrollBottom
      @_scrollToBottom()

  shouldComponentUpdate: (nextProps, nextState) ->
    @state.marginBottom isnt nextState.marginBottom or
    @state.scrollToBottom isnt nextState.scrollToBottom

  _scrollToBottom: ->
    $(@refs.messagesContainer).scrollTop @_getScrollHeight()

  _updateMarginBottom: (bottom, reset=false) ->
    if reset
      @setState @getInitialState()
    else
      @setState(marginBottom: bottom, scrollToBottom: false)

  _getScrollHeight: -> $(@refs.messagesContainer).prop("scrollHeight")

  _renderMessages: ->
    @data.messages.map (message) =>
      <TransitionFlashBG key={message._id}>
        <Message key={message._id} text={message.text} time={message.createdAt} />
      </TransitionFlashBG>

  render: ->
    props =
      style:
        marginBottom: @state.marginBottom

    <div id="messages-container" ref="messagesContainer" {...props}>
      <div id="messages" ref="messages">{@_renderMessages()}</div>
      <MessageInput parent={@} />
    </div>