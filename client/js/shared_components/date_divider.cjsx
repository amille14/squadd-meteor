class @DateDivider extends React.Component
  @propTypes:
    date: React.PropTypes.instanceOf(Date).isRequired

  shouldComponentUpdate: (np, ns)->
    !_.isEqual(@props.date, np.date)

  render: ->
    today = moment()
    yesterday = moment().subtract(1, "day")
    date = moment(@props.date)

    if date.isSame(today, "day")
      dateText = "Today"
    else if date.isSame(yesterday, "day")
      dateText = "Yesterday"
    else
      dateText = date.format("dddd, MMMM Do")

    <div className="date-divider">
      <div className="small date">{dateText}</div>
    </div>