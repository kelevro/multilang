//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery.autosize
//= require spin
//= require ladda
//= require_tree .
//= require_self

(function () {
  $('textarea').autosize();
  Ladda.bind('.ladda-button');
})();

