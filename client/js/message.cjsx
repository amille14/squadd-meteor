@Message = React.createClass
  mixins: [Destruct]

  propTypes:
    text: React.PropTypes.string.isRequired
    time: React.PropTypes.instanceOf(Date).isRequired

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

  render: ->
    props = @destruct(@props, ["text", "time", "username", "isFirst"])

    className = "message clearfix"
    className += if props.isFirst then " first" else " not-first"

    <div className={className} {...props._other}>
      {<div className="message-photo user-photo"></div> if props.isFirst}
      {<div className="message-username">{props.username}</div> if props.isFirst}
      <div className="message-text">{@_renderText(props.text)}</div>
      <small className="message-time">{moment(props.time).format("h:mm a")}</small>
    </div>
