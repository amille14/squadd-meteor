@FloatLabelInput = React.createClass
  mixins: [Destruct]

  getInitialState: ->
    {filled: false}

  propTypes:
    label: React.PropTypes.string.isRequired

  getValue: ->
    @refs.input.value

  shouldComponentUpdate: (nextProps, nextState) ->
    !_.isEqual(@state, nextState) or !_.isEqual(@props, nextProps)

  _onChange: (e) ->
    @setState(filled: true) if @refs.input.value

  render: ->
    props = @destruct(@props, ["label", "isValid", "groupStyle", "onChange", "className"])

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