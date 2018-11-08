// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require materialize-sprockets
//= require_tree .


var coords = ["-27.62719542,-52.24613067",
  "-27.62711579,-52.24606219",
  "-27.62686814,-52.24569963",
  "-27.62650591,-52.24510402",
  "-27.62616441,-52.24454095",
  "-27.62584229,-52.24399813",
  "-27.62532928,-52.24314813",
  "-27.62465397,-52.24206382",
  "-27.62391947,-52.24085906",
  "-27.62318756,-52.23965212",
  "-27.62252322,-52.23854545",
  "-27.62213902,-52.237848",
  "-27.62209599,-52.23758951",
  "-27.62206121,-52.23741496",
  "-27.62178402,-52.23716792",
  "-27.62131964,-52.23654896",
  "-27.62073887,-52.23563598",
  "-27.62005888,-52.23455696",
  "-27.61934604,-52.23340397",
  "-27.61862865,-52.23220433",
  "-27.61793043,-52.2311078",
  "-27.61746868,-52.23011722",
  "-27.61710109,-52.22963842",
  "-27.61683629,-52.22948712",
  "-27.6164707,-52.2294391",
  "-27.61609861,-52.22936009",
  "-27.61600627,-52.22934475",
  "-27.61600614,-52.22934441",
  "-27.61600898,-52.22934351",
  "-27.61601049,-52.22934298",
  "-27.61601331,-52.22934321"
]

$(document).on('turbolinks:load', function() {
  $('#gesso').click(function() {
    post(0)
  })

  function post(counter) {
    if (counter === coords.length) {
      return
    }
    setTimeout(function() {
      $.post({
          url: 'http://track-j.herokuapp.com/api/v1/posicoes/post_posicoes',
          data: {
            token: "fb24239cefa19d5f025cceae7b63cb54",
            coordenadas_geograficas: coords[counter]
          }
        }).done(function(data) {
          console.log('OK', data);
        })
        .fail(function(err) {
          console.log('ERRO', err);
        })
      return post(counter + 1)
    }, 5000)
  }
})
