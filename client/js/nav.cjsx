@Nav = React.createClass
  render: ->
    <div id="nav" className="clearfix">
      <SidebarNav />
      <div className="nav-group pull-left">
        {!<h4>The Nerd Brigade</h4>}
      </div>
      <div id="nav-menu" className="nav-group">
        <a href="/logout">Log out</a>
      </div>
    </div>

@SidebarNav = React.createClass
  render: ->
    <div id="sidebar-nav" className="nav-group">
      <SquaddLogo />
    </div>