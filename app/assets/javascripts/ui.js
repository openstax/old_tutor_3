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
    },

    // refreshWidgets: function() {
    //   this.refreshButtons();
    //   this.refreshDatetimePickers();
    // },

    // refreshButtons: function() {
    //   $('input:submit').button();
    //   $('.button').button();
    //   $(".show_button").button({icons: {primary: "ui-icon-search"}, text: false });
    //   $(".edit_button").button({icons: {primary: "ui-icon-pencil"}, text: false });
    //   $(".trash_button").button({icons: {primary: "ui-icon-trash"}, text: false });
    //   $(".calendar_button").button({icons: {primary: "ui-icon-calendar"}, text: false });
    // },

    // refreshDatetimePickers: function() {
    //   $(".date_time_picker").each( function(index) {
    //     $(this).datetimepicker({
    //       numberOfMonths: parseInt($(this).attr("number_of_months")) || 3,
    //       timeFormat:     $(this).attr("time_format")                || 'h:mm TT', // this only takes effect after refresh
    //       dateFormat:     $(this).attr("date_format")                || 'M d, yy', // this only takes effect after refresh
    //       stepMinute:     parseInt($(this).attr("step_minute"))      || 1, 
    //       ampm:           true, 
    //       hour:           parseInt($(this).attr("hour"))             || 9,
    //       minute:         parseInt($(this).attr("minute"))           || 0
    //     });
    //   });
    // }
  }

}();
