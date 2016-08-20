pathFor = (path, params) =>
  query = if params and params.query then FlowRouter._qs.parse(params.query) else {}
  return FlowRouter.path(path, params, query)

urlFor = (path, params) =>
  return Meteor.absoluteUrl pathFor(path, params)

@FlowHelpers =
  pathFor: pathFor
  urlFor: urlFor