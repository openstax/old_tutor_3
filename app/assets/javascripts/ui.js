Tutor.Ui = function() {

  // Private vars / functions here
  // var x = blah;
  // var privateFunc = function(...)

  return {
    disableButton: function(selector) {
      $(selector).attr('disabled', 'disabled');
      $(selector).addClass('ui-state-disabled ui-button-disabled');
      $(selector).attr('aria-disabled', true);
    },

    enableButton: function(selector) {
      $(selector).removeAttr('disabled');
      $(selector).removeAttr('aria-disabled');
      $(selector).removeClass('ui-state-disabled ui-button-disabled');
      $(selector).button();
    }
  }

}();
