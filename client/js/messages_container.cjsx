@MessagesContainer = React.createClass
  mixins: [ReactMeteorData]

  getMeteorData: ->
    return {
      messages: Messages.find({}).fetch()
    }

  componentDidMount: ->
    @_scrollToBottom()

  componentDidUpdate: (nextProps, nextState) ->
    @_scrollToBottom()  # TODO: Only if latest message is the user's own message

  _scrollToBottom: ->
    $(@refs.messagesContainer).scrollTop $(@refs.messagesContainer).prop("scrollHeight")

  _renderMessages: ->
    @data.messages.map (message) =>
      <Message key={message._id} text={message.text} time={message.createdAt} />

  render: ->
    <div id="messages-container" ref="messagesContainer">
      <div id="messages">{@_renderMessages()}</div>
      <MessageInput />
    </div>


#=== MESSAGE ===
@Message = React.createClass
  mixins: [Destruct]

  propTypes:
    text: React.PropTypes.string.isRequired

  renderText: (text) ->
    # Render multi-line comments
    lines = text.split(new RegExp('\r?\n','g'))
    lines.map (line, index) ->
      <p className="message-text" key={index}>{line}</p> 

  render: ->
    props = @destruct(@props, ["text", "time"])

    <div className="message clearfix" {...props._other}>
      <div className="pull-left">{@renderText(props.text)}</div>
      <small className="message-time inline pull-right">{moment(props.time).format("h:mm a")}</small>
    </div>