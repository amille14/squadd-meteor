@Message = React.createClass
  mixins: [Destruct]

  _renderText: (text) ->
    # Split multi-line comments so each line can be rendered separately
    lines = text.split(new RegExp('\r?\n','g'))

    # Automatically add links (see https://github.com/gregjacobs/Autolinker.js)
    autolinker = new Autolinker
      newWindow: true
      stripPrefix: false
      twitter: false
      hashtag: false

    lines.map (line, index) =>
      innerHtml = 
        __html: autolinker.link(@_htmlEscape(line))

      <p className="message-text" key={index} dangerouslySetInnerHTML={innerHtml}></p> 

  _htmlEscape: (text) -> $("<div></div>").text(text).html()

  shouldComponentUpdate: (nextProps, nextState) ->
    !_.isEqual(@props, nextProps)

  render: ->
    console.log "RENDERED MESSAGE", @props.message
    props = @destruct(@props, ["message", "prevMessage"])

    m    = props.message
    prev = props.prevMessage

    # Message is the first of its group (i.e. we should append username/avatar) if previous
    # message's user is different or last message from the same user was greater than 10 minutes ago.
    if prev?
      isFirst = prev.user?._id isnt m.user?._id or
                moment(prev.createdAt).diff(moment(m.createdAt), 'minutes') <= -10

    className = "message clearfix"
    className += " first" if isFirst

    <div className={className} {...props._other}>
      {<div className="message-photo user-avatar"></div> if isFirst}
      {<div className="message-username">{m.user?.username}</div> if isFirst}
      <div className="message-text-container">{@_renderText(m.content)}</div>
      <small className="message-time">{moment(m.createdAt).format("h:mm a")}</small>
    </div>
