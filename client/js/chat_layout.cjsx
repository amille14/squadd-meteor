@ChatLayout = React.createClass
  render: ->
    <div id="chat-layout">
      <Sidebar />
      <Nav />
      <MessagesContainer />
    </div>