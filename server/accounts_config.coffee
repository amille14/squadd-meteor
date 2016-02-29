# Configure user accounts
Accounts.config
  sendVerificationEmail: true
  loginExpirationInDays: 60

# Validate username length
Accounts.validateNewUser (newUser) ->
  if newUser.username?.length >= 3
    return true
  throw new Meteor.Error(422, "Username must have at least 3 characters", newUser)

# Validate password
Accounts.validateNewUser (newUser) ->
  if newUser.services.password?
    return true
  throw new Meteor.Error(422, "Password can't be blank", newUser)

# After user creation
Accounts.onCreateUser (options, newUser) ->
  console.log "CREATE USER"
  newUser.profile = options.profile if options?.profile?
  return newUser
