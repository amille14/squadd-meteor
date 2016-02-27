# Implements jsx destructure, since cjsx doesn't have it.
# Calling destruct(obj, keys) is the same as {keys..., ...other} = obj
@Destruct =
  destruct: (obj, keys) ->
    obj = _.clone obj
    destructed = {}
    keys = [keys] unless _.isArray keys

    for key in keys
      destructed[key] = obj[key]
      delete obj[key]
    destructed._other = obj

    return destructed