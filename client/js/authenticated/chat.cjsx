class @Chat extends React.Component
  constructor: (props) ->
    @state = @getDefaultState() 

  getDefaultState: ->
    marginBottom: 69

  setMarginBottom: (marginBottom) ->
    @setState marginBottom: marginBottom
    $(@refs.chatContainer).css "margin-bottom": marginBottom

  shouldComponentUpdate: (nextProps, nextState) ->
    !_.isEqual(@props, nextProps)

  render: ->
    <div id="chat-container" ref="chatContainer" style={{marginBottom: @state.marginBottom}}>
      <Messages ref="messages" messages={@props.messages} room={@props.room} />
      <ChatInput parent={@} />
    </div>