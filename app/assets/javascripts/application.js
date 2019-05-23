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
    if ($("#loan_name").val() === '' || $("#loan_amount").val() === '' || $("#loan_store").val() === '' || $("#loan_portion1").val() === '' || $("#loan_portion2").val() === '' || $("#loan_portion3").val() === '' || $("#date_p1").val() === '' || $("#date_p2").val() === '' || $("#date_p3").val() === '') {
      alert("Todos os campos devem ser preenchidos corretamente.");
    } else {
      var date1 = $("#date_p1").val().substr(6,4) + '-' + $("#date_p1").val().substr(3,2) + '-' + $("#date_p1").val().substr(0,2);
      var date2 = $("#date_p2").val().substr(6,4) + '-' + $("#date_p2").val().substr(3,2) + '-' + $("#date_p2").val().substr(0,2);
      var date3 = $("#date_p3").val().substr(6,4) + '-' + $("#date_p3").val().substr(3,2) + '-' + $("#date_p3").val().substr(0,2);
      $("#date_p1").val(date1);
      $("#date_p2").val(date2);
      $("#date_p3").val(date3);  
      $("#new-loan").removeClass("d-none");
      $("#new-loan-form").addClass("d-none");
      $("#cancel-loan").addClass("d-none");
        setTimeout(function() {
            $(".clear-field").val("");
            date1 = $("#date_p1").val().substr(8,2) + '/' + $("#date_p1").val().substr(5,2) + '/' + $("#date_p1").val().substr(0,4);
            date2 = $("#date_p2").val().substr(8,2) + '/' + $("#date_p2").val().substr(5,2) + '/' + $("#date_p2").val().substr(0,4);
            date3 = $("#date_p3").val().substr(8,2) + '/' + $("#date_p3").val().substr(5,2) + '/' + $("#date_p3").val().substr(0,4);
            $("#date_p1").val(date1);
            $("#date_p2").val(date2);
            $("#date_p3").val(date3);  
      }, 10);
    };
  });
  $("#cancel-loan").click(function() {
    $(".clear-field").val("");
    $("#new-loan").removeClass("d-none");
    $("#new-loan-form").addClass("d-none");
    $("#cancel-loan").addClass("d-none");
  });
  $("#filter-button").click(function() {
    console.log($("#filter-input").val() != '');
    if ($("#filter-input").val() != '') {
      $.ajax({
        method: 'get',
        url: '/loan/filtro/' + $("#filter-input").val()
      });
    } 
  })
})
