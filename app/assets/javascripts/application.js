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
  var date1;
  var date2;
  var date3;
  
  $("#new-loan").click(function(){
    $("#new-loan").addClass("d-none");
    $("#new-loan-form").removeClass("d-none");
    $("#cancel-loan").removeClass("d-none");
  });
   $("#new-loan-submit").click(function(){
    if ($("#loan_name").val() === '' || $("#loan_amount").val() === '' || $("#loan_store").val() === '' || $("#loan_portion1").val() === '' || $("#loan_portion2").val() === '' || $("#loan_portion3").val() === '' || $("#date_p1").val() === '' || $("#date_p2").val() === '' || $("#date_p3").val() === '') {
      alert("Todos os campos devem ser preenchidos corretamente.");
    } else {
      // Old way: the date was generated in backend, counting 1, 2 and 3 months from now.
      // var date1 = $("#date_p1").val().substr(6,4) + '-' + $("#date_p1").val().substr(3,2) + '-' + $("#date_p1").val().substr(0,2);
      // var date2 = $("#date_p2").val().substr(6,4) + '-' + $("#date_p2").val().substr(3,2) + '-' + $("#date_p2").val().substr(0,2);
      // var date3 = $("#date_p3").val().substr(6,4) + '-' + $("#date_p3").val().substr(3,2) + '-' + $("#date_p3").val().substr(0,2);
      // $("#date_p1").val(date1);
      // $("#date_p2").val(date2);
      // $("#date_p3").val(date3);
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
  });
  $("#loan_amount").focusout(function() {
    var amount = $("#loan_amount").val();
    amount = (amount / 3).toFixed(2);
    $("#loan_portion1").val(amount);
    $("#loan_portion2").val(amount);
    $("#loan_portion3").val(amount);
  });

  //New customer form validation
  $("#new-customer-submit").click(function() {
    if ($("#customer_name").val() == '') {
      alert("O nome é obrigatório no cadastro de cliente!");
    };
  })

  // New way to set date of payment
  $("#date_p1").focusout(function () {
      var month_p2 = parseInt($("#date_p1").val().substr(3, 2)) + 1;
      var year = parseInt($("#date_p1").val().substr(6, 4));
      if (month_p2 == 13) {
          month_p2 = '01';
          year += 1;
      } else if (month_p2 < 10) {
          month_p2 = '0' + month_p2;
      }

      var month_p3 = parseInt($("#date_p1").val().substr(3, 2)) + 2;
      if (month_p3 == 13) {
          month_p3 = '01';
      } else if (month_p3 == 14) {
          month_p3 = '02';
      } else if (month_p3 < 10) {
          month_p3 = '0' + month_p3;
      }

      $("#date_p2").val($("#date_p1").val().substr(0,2) + "/" + month_p2 + "/" + year);
      $("#date_p3").val($("#date_p1").val().substr(0,2) + "/" + month_p3 + "/" + year);

  })

})
