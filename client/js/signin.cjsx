{ createContainer } = require("meteor/react-meteor-data")

class Signin extends React.Component
  constructor: (props) ->
    super(props)
    @state =
      usernameValid: true
      passwordValid: true

  render: ->
    <div className="account-card-container">
      <img className="squadd-logo" src="/images/squadd-logo-flat.svg" />
      <div id="signin-card" className="card">
        <form id="signin-form" ref="signinForm" onSubmit={@_handleSubmit}>
          {@_renderErrorMessage()}
          <FloatLabelInput
            type="text"
            ref="usernameInput"
            id="username-input"
            label="Username / Email"
            name="username"
            isValid={true} />

          <FloatLabelInput
            type="password"
            ref="passwordInput"
            id="password-input"
            label="Password"
            name="password"
            isValid={true} />

          { if @props.loading
              <Loader style={fontSize: 12}/>
            else
              <button type="submit">Log in</button>
          }
          
        </form>
        <a href="/signup" className="small">Need an account? Sign up</a>
      </div>
    </div>

  _handleSubmit: (e) =>
    e.preventDefault()
    Meteor.loginWithPassword @refs.usernameInput.getValue(), @refs.passwordInput.getValue(), (error) =>
      if error?
        @setState error: error.reason
      else
        FlowRouter.go("/")

  _renderErrorMessage: ->
    if @state.error
      <Alert type="error" style={marginBottom: 24}>
        {@state.error}
      </Alert>

@Signin = createContainer ((props) =>
  return {
    loading: Meteor.loggingIn()
  }
), Signin