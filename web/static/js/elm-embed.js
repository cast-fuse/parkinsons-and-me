function init () {
  var node = document.getElementById('main')
  var app = Elm.Main.embed(node)
}

module.exports = { init }
