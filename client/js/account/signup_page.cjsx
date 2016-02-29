@SignupPage = React.createClass
  getInitialState: ->
    {usernameValid: true, emailValid: true, passwordValid: true, passwordScore: -1}

  _handleSubmit: (e) ->
    e.preventDefault()
  
  _validateUsername: (e) ->
    username = @refs.usernameInput.getValue()
    @setState usernameValid: !Meteor.users.findOne({username: username})

  _validateEmail: (e) ->
    # TODO

  _validatePassword: (e) ->
    password = @refs.passwordInput.getValue()
    score = if password then zxcvbn(password).score else -1
    @setState passwordValid: (score >= 2), passwordScore: score
    
  shouldComponentUpdate: (nextProps, nextState) ->
    @state isnt nextState

  render: ->
    <div id="signup-page">
      <form id="login-form" ref="loginForm" onSubmit={@_handleSubmit}>
        <SquaddLogo includeIcon={true} includeText={true} fileType="svg" />
        <FloatLabelInput
          type="text"
          ref="usernameInput"
          id="username-input"
          label="Username"
          name="username"
          autoComplete="on"
          onBlur={@_validateUsername}
          isValid={@state.usernameValid} />

        <FloatLabelInput
          type="email"
          ref="emailInput"
          id="email-input"
          label="Email"
          name="email"
          autoComplete="on"
          onBlur={@_validateEmail}
          isValid={@state.emailValid} />

        <FloatLabelInput
          type="password"
          ref="passwordInput"
          id="password-input"
          label="Password"
          name="password"
          autoComplete="on"
          onChange={@_validatePassword}
          isValid={@state.passwordValid} />
        

        <PasswordScoreBar score={@state.passwordScore} />
        <button type="submit">Sign up</button>
      </form>
    </div>