@PasswordScoreBar = React.createClass
  render: ->
    classNames = []
    for i in [0..4]
      classNames[i] = "score-#{i} score-bar"
      classNames[i] += " active" if @props.score >= i

    <div className="password-score-bar">
      <div className={classNames[0]}></div>
      <div className={classNames[1]}></div>
      <div className={classNames[2]}></div>
      <div className={classNames[3]}></div>
      <div className={classNames[4]}></div>
    </div>