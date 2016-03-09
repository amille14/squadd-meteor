@DateDivider = React.createClass
  propTypes:
    date: React.PropTypes.instanceOf(Date).isRequired

  shouldComponentUpdate: (np, ns)->
    !_.isEqual(@props.date, np.date)

  render: ->
    <div className="date-divider">
      <div className="small date">{moment(@props.date).format("dddd, MMMM Do")}</div>
    </div>