# Configure user accounts
Accounts.config
  sendVerificationEmail: true
  loginExpirationInDays: 60

# Validate username length
Accounts.validateNewUser (newUser) ->
  if newUser.username?.length >= 3
    return true
  throw new Meteor.Error(403, "Username must have at least 3 characters.", newUser)

# Validate password
Accounts.validateNewUser (newUser) ->
  if newUser.services.password?
    return true
  throw new Meteor.Error(403, "Password can't be blank.", newUser)

# After user creation
Accounts.onCreateUser (options, newUser) ->
  newUser.profile = options.profile if options?.profile?
  return newUser
