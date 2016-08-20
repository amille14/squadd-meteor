class @ChatInput extends React.Component
  constructor: (props) ->
    @state = @getDefaultState()

  getDefaultState: ->
    height: 24
    justSubmitted: false

  #=== LIFECYCLE ===
  shouldComponentUpdate: (nextProps, nextState) ->
    !_.isEqual(@state, nextState)

  componentDidUpdate: ->
    p = @props.parent
    m = @props.parent.refs.messages

    # Reset to original margin bottom after submit
    if @state.justSubmitted
      p.setMarginBottom p.getDefaultState().marginBottom
      m.setState shouldScrollBottom: true

    # Update margin bottom of parent to accomodate for height of input container
    else
      p.setMarginBottom $(@refs.chatInputContainer).outerHeight()
      m.forceUpdate()

    @setState justSubmitted: false


  #=== HANDLERS ===
  _handleSubmit: (e) =>
    e?.preventDefault()
    text = @refs.chatInput.value?.trim()
    if text? and text isnt ""
      Meteor.call "messages.insert", text, Session.get("currentRoomId")
      @refs.chatInput.value = ""
      @setState {height: @getDefaultState().height, justSubmitted: true}

  _handleKeyPress: (e) =>
    if e.which is 13 and !e.shiftKey  # Submit when enter key is pressed
      e.preventDefault()
      @_handleSubmit()

  _handleKeyDown: (e) =>
    # TODO: Do something when up arrow key is pressed
    # if e.which is 38 and (@refs.chatInput.value is "" or !@refs.chatInput.value?)

  _handleChange: (e) =>
    MAX_LENGTH = 5000
    @refs.chatInput.value = @refs.chatInput.value.substring(0, MAX_LENGTH)
    @_updateHeight()

  _updateHeight: =>
    MAX_HEIGHT = 164
    LINE_HEIGHT = 20

    # Funky hack to calculate scrollHeight:
    # Need to first set height to 0 in order to get the correct value of scrollHeight after a backspace.
    # Then need to set the new height.
    $(@refs.chatInput).css(height: 0)
    scrollHeight = @refs.chatInput.scrollHeight
    h = (scrollHeight - (scrollHeight % LINE_HEIGHT)) + 4 
    newHeight = Math.min(h, MAX_HEIGHT)

    $(@refs.chatInput).css(height: newHeight) 
    @setState({height: newHeight})


  #=== RENDERING ===
  render: ->
    props =
      style:
        height: @state.height

    <div id="chat-input-container" ref="chatInputContainer">
      <form onSubmit={@_handleSubmit} ref="chatForm" id="chat-input-form">
        <textarea id="chat-input"
                  ref="chatInput"
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
