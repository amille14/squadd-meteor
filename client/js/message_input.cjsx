@MessageInput = React.createClass
  getInitialState: ->
    {height: 42}

  shouldComponentUpdate: (nextProps, nextState) ->
    @state.height isnt nextState.height

  componentDidUpdate: ->
    @props.parent._updateMarginBottom $(@refs.messageInputContainer).outerHeight(), @justSubmitted
    @justSubmitted = false

  _handleSubmit: (e) ->
    e?.preventDefault()
    text = @refs.messageInput.value?.trim()
    if text? and text isnt ""
      db.messages.insert
        text: text
        createdAt: new Date()
        user:
          _id: Meteor.userId()
          username: Meteor.user().username
          profile:
            firstName: Meteor.user().firstName
            lastName: Meteor.user().lastName
            photo: Meteor.user().photo

      @refs.messageInput.value = ""
      @setState {height: @getInitialState().height}
      @justSubmitted = true

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

  render: ->
    props =
      style:
        height: @state.height

    <div id="message-input-container" ref="messageInputContainer">
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
    </div>
