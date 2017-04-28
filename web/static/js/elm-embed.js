function init () {
  var node = document.getElementById('main')
  var app = Elm.Main.embed(node)

  app.ports.trackLink.subscribe(trackOutboundLink)
}

module.exports = { init }
