@App = React.createClass
  render: =>
    # TODO: Move this logic to router

    <div id="app">
      {
        if Meteor.user()?
          (
            <Sidebar />
            <Nav />
            <MessagesContainer />
          )
        else
          <SignupPage />
      }
    </div>