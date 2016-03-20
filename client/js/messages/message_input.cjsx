@MessageInput = React.createClass
  getInitialState: ->
    {height: 24, justSubmitted: false}

  #=== LIFECYCLE ===
  shouldComponentUpdate: (nextProps, nextState) ->
    !_.isEqual(@state, nextState)

  componentDidUpdate: ->
    p = @props.parent
    m = @props.parent.refs.messages

    # Reset to original margin bottom after submit
    if @state.justSubmitted
      p.setMarginBottom p.getInitialState().marginBottom
      m.setState shouldScrollBottom: true

    # Update margin bottom of parent to accomodate for height of input container
    else
      p.setMarginBottom $(@refs.messageInputContainer).outerHeight()
      m.forceUpdate()

    @setState justSubmitted: false


  #=== CALLBACKS ===
  _handleSubmit: (e) ->
    e?.preventDefault()
    text = @refs.messageInput.value?.trim()
    if text? and text isnt ""
      Meteor.call "insertMessage", text
      @refs.messageInput.value = ""
      @setState {height: @getInitialState().height, justSubmitted: true}

  _handleKeyPress: (e) ->
    if e.which is 13 and !e.shiftKey  # Submit when enter key is pressed
      e.preventDefault()
      @_handleSubmit()

  _handleKeyDown: (e) ->
    # TODO: Do something when up arrow key is pressed
    # if e.which is 38 and @refs.messageInput.value is "" or !@refs.messageInput.value?

  _handleChange: (e) ->
    MAX_LENGTH = 5000
    @refs.messageInput.value = @refs.messageInput.value.substring(0, MAX_LENGTH)
    @_updateHeight()

  _updateHeight: ->
    MAX_HEIGHT = 164
    LINE_HEIGHT = 20

    # Funky hack to calculate scrollHeight:
    # Need to first set height to 0 in order to get the correct value of scrollHeight after a backspace.
    # Then need to set the new height.
    $(@refs.messageInput).css(height: 0)
    scrollHeight = @refs.messageInput.scrollHeight
    h = (scrollHeight - (scrollHeight % LINE_HEIGHT)) + 4 
    newHeight = Math.min(h, MAX_HEIGHT)

    $(@refs.messageInput).css(height: newHeight) 
    @setState({height: newHeight})


  #=== RENDERING ===
  render: ->
    console.log "RENDERED INPUT"
    props =
      style:
        height: @state.height

    <div id="message-input-container" ref="messageInputContainer">
      <form onSubmit={@_handleSubmit} ref="messageForm" id="message-input-form">
        <textarea id="message-input"
                  ref="messageInput"
                  onChange={@_handleChange}
                  onKeyPress={@_handleKeyPress}
                  onKeyDown={@_handleKeyDown}
                  autoCorrect="off"
                  autoComplete="off"
                  spellCheck="true"
                  placeholder="type something..."
                  {...props} />
      </form>
    </div>
