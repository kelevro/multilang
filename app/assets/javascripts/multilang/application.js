//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require rails.validations
//= require jquery.autosize
//= require spin
//= require ladda
//= require_tree .
//= require_self

(function () {
  $('textarea').autosize();
  Ladda.bind('.ladda-button');
})();

ClientSideValidations.formBuilders['SimpleForm::FormBuilder'] = {
  add: function(element, settings, message) {
    var errorElement, wrapper_class_element, wrapper_tag_element;
    errorElement = element.parent().find("" + settings.error_tag + "." + settings.error_class);
    if (errorElement[0] == null) {
      wrapper_tag_element = element.closest(settings.wrapper_tag);
      errorElement = $("<" + settings.error_tag + "/>", {
        "class": settings.error_class,
        text: message
      });
      wrapper_tag_element.append(errorElement);
    }
    wrapper_class_element = element.closest("." + settings.wrapper_class);
    wrapper_class_element.addClass(settings.wrapper_error_class);
    return errorElement.text(message);
  },
  remove: function(element, settings) {
    var errorElement, wrapper_class_element, wrapper_tag_element;
    wrapper_class_element = element.closest("." + settings.wrapper_class + "." + settings.wrapper_error_class);
    wrapper_tag_element = element.closest(settings.wrapper_tag);
    wrapper_class_element.removeClass(settings.wrapper_error_class);
    errorElement = wrapper_tag_element.find("" + settings.error_tag + "." + settings.error_class);
    return errorElement.remove();
  }
};
