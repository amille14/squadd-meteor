@ReactCSSTransitionGroup = React.addons.CSSTransitionGroup
@ReactTransitionGroup = React.addons.ReactTransitionGroup

@TransitionFlashBG = React.createClass
  render: ->
    <ReactCSSTransitionGroup
      transitionName="flash-bg"
      transitionAppear={true}
      transitionAppearTimeout={1000}
      transitionEnterTimeout={1000}
      transitionLeaveTimeout={1000}
      {...@props} />