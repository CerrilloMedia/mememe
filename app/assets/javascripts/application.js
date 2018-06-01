// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//
//

function alertFade(duration=5, buffer=1, remove=true) {
  var alert = document.getElementsByClassName('alert')[0];
  console.log(alert);
  if (alert) {
    alert.style.opacity = "1";

    var duration = duration * 1000;
    var buffer = buffer * 1000;
    var timeout = duration / 100;

    var alertTimer;
    setTimeout(function() {
      alertTimer = setInterval(function() {
        var opacity = parseFloat(alert.style.opacity);
        alert.style.opacity = (opacity - 1/100);
      }, timeout);
    }, buffer);

    setTimeout(function() {
      clearInterval(alertTimer);
      if (remove) {
        alert.style.display = 'none';
      }
    }, duration + buffer);
  }
}

window.onload = function() {
  alertFade(2,5);
};
