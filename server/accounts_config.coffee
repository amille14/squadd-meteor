# Configure user accounts
Accounts.config
  sendVerificationEmail: true
  loginExpirationInDays: 60

# Validate username
Accounts.validateNewUser (newUser) ->
  return true if newUser.username?.length >= 3 and newUser.username?.length <= 30
  throw new Meteor.Error(403, "Username must be 3 to 30 characters long.", newUser)

Accounts.validateNewUser (newUser) ->
  return true if newUser.username?.match(/^[A-Za-z0-9_]+$/)
  throw new Meteor.Error(403, "Username can only contain letters, numbers, and underscores.", newUser)

# Validate password
Accounts.validateNewUser (newUser) ->
  if newUser.services.password?
    return true
  throw new Meteor.Error(403, "Password can't be blank.", newUser)

# After user creation
Accounts.onCreateUser (options, newUser) ->
  newUser.profile = options.profile if options?.profile?
  return newUser
