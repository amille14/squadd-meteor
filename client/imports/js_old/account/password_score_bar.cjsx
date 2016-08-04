@PasswordScoreBar = React.createClass
  render: ->
    classNames = []
    for i in [0..4]
      classNames[i] = "score-#{i} score-bar"
      classNames[i] += " active" if @props.score >= i

    text = switch @props.score
      when 0, 1 then "too weak"
      when 2 then "ok"
      when 3 then "good"
      when 4 then "great!"

    textClass = "password-score-text"
    textClass += " good" if @props.score >= 2

    <div className="password-score-bar">
      <div className={classNames[0]}></div>
      <div className={classNames[1]}></div>
      <div className={classNames[2]}></div>
      <div className={classNames[3]}></div>
      <div className={classNames[4]}></div>
      <div className={textClass}>{text}</div>
    </div>