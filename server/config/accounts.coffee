Meteor.startup ->
  Accounts.config
    sendVerificationEmail: true
    loginExpirationInDays: 60

  # Validate password existance
  Accounts.validateNewUser (newUser) ->
    return true if newUser.services.password?
    throw new Meteor.Error(403, "Password can't be blank.", newUser)

  # After user creation, set user's profile
  Accounts.onCreateUser (options, newUser) ->
    newUser.profile = options.profile if options?.profile?
    return newUser

  AUTH_METHODS = [
    'login'
    'logout'
    'logoutOtherClients'
    'getNewToken'
    'removeOtherTokens'
    'configureLoginService'
    'changePassword'
    'forgotPassword'
    'resetPassword'
    'verifyEmail'
    'createUser'
    'ATRemoveService'
    'ATCreateUserServer'
    'ATResendVerificationEmail'
  ]

  # Only allow 2 login attempts per connection per 5 seconds
  DDPRateLimiter.addRule
    name: (name) ->
      _.contains AUTH_METHODS, name
      
    # Rate limit per connection ID
    connectionId: ->
      yes
  , 2, 5000