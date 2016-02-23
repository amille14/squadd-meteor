@MainContainer = React.createClass
  # mixins: [ReactMeteorData]

  render: ->
    <div id="main-container">
      <MessageInput />
    </div>

MessageInput = React.createClass
  handleSubmit: (e) ->
    e?.preventDefault()
    console.log "SUBMITTED", @refs.messageInput.value?.trim()
    @refs.messageInput.value = ""

  handleKeyPress: (e) ->
    if e.which is 13 and !e.shiftKey
      e.preventDefault()
      @handleSubmit()
    else
      @setState

  setHeight: ->
    if @isMounted()
      h = @refs.messageInput.scrollHeight
    else
      h = 50
    console.log h
    return h

  render: ->
    console.log "RENDERED"
    <form onSubmit={@handleSubmit} ref="messageForm" id="message-input-form">
      <textarea id="message-input"
                ref="messageInput"
                onKeyPress={@handleKeyPress}
                autoCorrect="off"
                autoComplete="off"
                spellCheck="true"
                placeholder="type something..."
                style={height: 50}/>
    </form>