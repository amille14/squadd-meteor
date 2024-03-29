{ createContainer } = require("meteor/react-meteor-data")
zxcvbn = require("../../node_modules/zxcvbn")

class Signup extends React.Component
  constructor: (props) ->
    super(props)
    @state = 
      usernameValid: true
      emailValid: true
      passwordValid: true
      passwordScore: -1

  #=== LIFECYCLE ===
  shouldComponentUpdate: (nextProps, nextState) ->
    !_.isEqual(@state, nextState)

  #=== RENDERING ===
  render: ->
    <div className="account-card-container">
      <img className="squadd-logo" src="/images/squadd-logo-flat.svg" />
      <div id="signup-card" className="card">
        <form id="signup-form" ref="signupForm" onSubmit={@_handleSubmit}>
          {@_renderErrorMessage()}
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
          { if @props.loading
              <Loader style={fontSize: 12}/>
            else
              <button type="submit">Sign up</button>
          }
        </form>
        <a href="/login" className="small">Already have an account? Log in</a>
      </div>
    </div>
    
  _renderErrorMessage: ->
    if @state.error
      <Alert type="error" style={marginBottom: 24}>
        {@state.error}
      </Alert>

  #=== HANDLERS & VALIDATIONS ===
  _handleSubmit: (e) =>
    e.preventDefault()

    if !@state.passwordValid
      @setState error: "Password is too weak."
    else
      Accounts.createUser {
        username: @refs.usernameInput.getValue()
        email: @refs.emailInput.getValue()
        password: @refs.passwordInput.getValue()
      }, (error) =>
        if error?
          @setState error: error.reason
          console.log "ERROR", error
        else
          FlowRouter.go("/")
  
  _validateUsername: (e) =>
    username = @refs.usernameInput.getValue()
    @setState usernameValid: !Meteor.users.findOne({username: username})

  _validateEmail: (e) =>
    # TODO

  _validatePassword: (e) =>
    password = @refs.passwordInput.getValue()
    score = if password then zxcvbn(password).score else -1
    @setState passwordValid: (score >= 2), passwordScore: score



@Signup = createContainer ((props) =>
  return {
    loading: Meteor.loggingIn()
  }
), Signup