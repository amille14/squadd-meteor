@LoginCard = React.createClass
  getInitialState: ->
    {usernameValid: true, passwordValid: true}

  _handleSubmit: (e) ->
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

  render: ->
    <div id="login-card" className="card">
      <SquaddLogo includeIcon={true} includeText={true} fileType="svg" />
      <form id="login-form" ref="loginForm" onSubmit={@_handleSubmit}>
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

        <button type="submit">Log in</button>
      </form>
      <a href="/signup" className="small">Need an account? Sign up</a>
    </div>