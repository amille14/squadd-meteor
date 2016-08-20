destruct = require("../imports/destruct") 

class @Alert extends React.Component
  constructor: (props) ->
    super(props)
    @state =
      type: "warning"

  @propTypes:
    type: React.PropTypes.string.isRequired

  render: ->
    props = destruct(@props, "type", "children")
    <div className="alert alert-#{props.type}" {...props._other}>
      {@props.children}
    </div>