{ createContainer } = require("meteor/react-meteor-data")

class App extends React.Component
  render: ->
    <div id="app">
      { if @props.loading
          <div>APP LOADING</div>  # TODO: Change me to real loading spinner
        else
          @props.yield
      }
    </div>

@App = createContainer ((props) =>
  return {
    loading: Meteor.loggingIn()
  }
), App



  # getMeteorData: ->
  #   return {
  #     loggingIn: Meteor.loggingIn()
  #   }

  # render: ->
  #   <div id="app">
  #   {
  #     if @data.loggingIn
  #       <div className="centered" style={marginTop: 240}>
  #         <Loader />
  #       </div>

  #     else
  #       @props.yield
  #   }
  #   </div>