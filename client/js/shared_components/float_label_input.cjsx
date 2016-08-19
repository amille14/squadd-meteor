destruct = require("../imports/destruct")

class @FloatLabelInput extends React.Component
  constructor: (props) ->
    super(props)
    @state =
      filled: false

  @propTypes: ->
    label: React.PropTypes.string.isRequired

  #=== LIFECYCLE ===
  shouldComponentUpdate: (nextProps, nextState) ->
    !_.isEqual(@state, nextState) or !_.isEqual(@props, nextProps)

  #=== HANDLERS ===
  _onChange: (e) ->
    @setState(filled: @refs.input.value)

  #=== PUBLIC METHODS ===
  getValue: ->
    @refs.input.value

  #=== RENDERING ===
  render: ->
    props = destruct(@props, ["label", "isValid", "groupStyle", "onChange", "className"])

    className = "float-label-input-group input-group "
    className += props.className if props.className?
    if props.isValid
      className += " valid"
    else
      className += " invalid"

    onChange = (e) =>
      @_onChange(e)
      props.onChange(e) if props.onChange?

    <div className={className} style={props.groupStyle}>
      <input ref="input" {...props._other} onChange={onChange} required={true} className={if @state.filled then "filled" else ""} />
      <label>{props.label}</label>
    </div>
