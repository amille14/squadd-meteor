@App = React.createClass
  mixins: [ReactMeteorData]

  getMeteorData: ->
    return {
      loggingIn: Meteor.loggingIn()
    }

  render: ->
    <div id="app">
    { if true #@data.loggingIn
        <div className="centered">
          <Loader />
        </div>

      else
        @props.yield
    }
    </div>