class @Messages extends React.Component

  constructor: (props) ->
    @state = 
      shouldScrollBottom: true

  #=== LIFECYCLE ===
  componentDidMount: ->
    @_scrollToBottom()

  shouldComponentUpdate: (np, ns) ->
    (@state.shouldScrollBottom isnt ns.shouldScrollBottom and ns.shouldScrollBottom is true) or !_.isEqual(@props, np)

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
    @props.messages.map (message) =>
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
    <div className="messages-container" ref="messages">{@_renderMessages()}</div>