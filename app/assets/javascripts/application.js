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
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require dateRangePicker/moment.min
//= require dateRangePicker/dateRangePicker
//= require bootstrap/bootstrap.min
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function() {
  
  $("#new-loan").click(function(){
    $("#new-loan").addClass("d-none");
    $("#new-loan-form").removeClass("d-none");
    $("#cancel-loan").removeClass("d-none");
  });
   $("#new-loan-submit").click(function(){
    var date = $("#firstPayment").val().substr(6,4) + '-' + $("#firstPayment").val().substr(3,2) + '-' + $("#firstPayment").val().substr(0,2);
    $("#firstPayment").val(date);
    $("#new-loan").removeClass("d-none");
    $("#new-loan-form").addClass("d-none");
    setTimeout(function() {
            $(".form-control").val("");
    }, 10);
  });
  $("#cancel-loan").click(function() {
    $(".form-control").val("");
    $("#new-loan").removeClass("d-none");
    $("#new-loan-form").addClass("d-none");
    $("#cancel-loan").addClass("d-none");
  });

  $('input[name="loan[firstPayment]"]').daterangepicker({
     singleDatePicker: true,
    "locale": {
        "format": "DD/MM/YYYY",
        "separator": "/",
        "applyLabel": "Apply",
        "cancelLabel": "Cancel",
        "fromLabel": "From",
        "toLabel": "To",
        "customRangeLabel": "Custom",
        "weekLabel": "W",
        "daysOfWeek": [
            "Dom",
            "Seg",
            "Ter",
            "Quar",
            "Qui",
            "Sex",
            "Sab"
        ],
        "monthNames": [
            "Janeiro",
            "Fevereiro",
            "Março",
            "Abril",
            "Maio",
            "Junho",
            "Julho",
            "Agosto",
            "Setembro",
            "Outubro",
            "Novembro",
            "Dezembro"
        ],
        "firstDay": 1
    }
});
})
