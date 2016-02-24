@MainContainer = React.createClass
  # mixins: [ReactMeteorData]

  render: ->
    <div id="main-container">
      <MessageInput />
    </div>

MessageInput = React.createClass
  getInitialState: ->
    {height: 42}

  shouldComponentUpdate: (nextProps, nextState) ->
    @state.height isnt nextState.height

  render: ->
    props =
      style:
        height: @state.height

    <form onSubmit={@_handleSubmit} ref="messageForm" id="message-input-form">
      <textarea id="message-input"
                ref="messageInput"
                onChange={@_updateHeight}
                onKeyPress={@_handleKeyPress}
                autoCorrect="off"
                autoComplete="off"
                spellCheck="true"
                placeholder="type something..."
                {...props} />
    </form>

  _handleSubmit: (e) ->
    e?.preventDefault()
    console.log "SUBMITTED", @refs.messageInput.value?.trim()
    @refs.messageInput.value = ""
    @setState {height: @getInitialState().height}

  _handleKeyPress: (e) ->
    if e.which is 13 and !e.shiftKey
      e.preventDefault()
      @_handleSubmit()

  _updateHeight: ->
    MAX_HEIGHT = 164
    LINE_HEIGHT = 18

    # Funky hack to calculate scrollHeight:
    # Need to first set height to 0 in order to get the correct value of scrollHeight after a backspace.
    # Then need to set the new height.
    $(@refs.messageInput).css(height: 0)
    scrollHeight = @refs.messageInput.scrollHeight
    h = (scrollHeight - (scrollHeight % LINE_HEIGHT)) + 6   
    newHeight = Math.min(h, MAX_HEIGHT)
    
    $(@refs.messageInput).css(height: newHeight) 
    @setState({height: newHeight})

