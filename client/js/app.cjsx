@App = React.createClass
  mixins: [ReactMeteorData]

  getMeteorData: ->
    return {
      loggingIn: Meteor.loggingIn()
    }

  render: ->
    <div id="app">
    {
      if @data.loggingIn
        <div className="centered" style={marginTop: 240}>
          <Loader />
        </div>

      else
        @props.yield
    }
    </div>