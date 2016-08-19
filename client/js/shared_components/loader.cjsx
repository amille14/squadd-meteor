destruct = require('../imports/destruct')

class @Loader extends React.Component
  render: ->
    props = destruct(@props, "className")
    className = "loader "
    className += props.className if props.className?
    <div className={className} {...props._other}>
      <div className="ball"></div>
      <div className="ball"></div>
      <div className="ball"></div>
    </div>