ReactCSSTransitionGroup = require('react-addons-css-transition-group')
ReactTransitionGroup = require('react-addons-transition-group')

class @TransitionFlashBG extends React.Component
  render: ->
    <ReactCSSTransitionGroup
      transitionName="flash-bg"
      transitionAppear={true}
      transitionAppearTimeout={1000}
      transitionEnterTimeout={1000}
      transitionLeaveTimeout={1000}
      {...@props} />