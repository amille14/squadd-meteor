# Configure user accounts
Accounts.config
  sendVerificationEmail: true
  loginExpirationInDays: 60

# Validate username length
Accounts.validateNewUser (newUser) ->
  if newUser.username?.length >= 3
    return true
  throw new Meteor.Error(422, "Username must have at least 3 characters")

# Validate password
Accounts.validateNewUser (newUser) ->
  if newUser.password?
    return true
  throw new Meteor.Error(422, "Password can't be blank")

Accounts.validateNewUser (newUser) ->
  if newUser.password? and zxcvbn(newUser.password)
    return true
  throw new Meteor.Error(422, "Password isn't strong enough")