'use strict';
var app = angular.module("gerenciamento")

app.controller("customerShowCtrl", ["$scope", "$location", "$log", "$http", function ($scope, $location, $log, $http) {
    $scope.customerId = $location.absUrl().substring($location.absUrl().lastIndexOf("/")+1, $location.absUrl().length);
    $scope.customer = [];
    $scope.loans = [];


    $scope.getDates = function() {
        $scope.newLoanObj = {};
        $http.get('/loan/api/getdates/').then(function (response) {
            $scope.newLoanObj.date_p1 = new Date(response.data.data.date_p1);
            $scope.newLoanObj.date_p2 = new Date(response.data.data.date_p2);
            $scope.newLoanObj.date_p3 = new Date(response.data.data.date_p3);
        });
    };
    $scope.getDates();
    $http.get('/customer/api/getcustomer/'+$scope.customerId).then(function (response) {
        $scope.customer = response.data.data;

        $http.get('/loan/api/getcustomerloans/'+$scope.customerId).then(function (response) {
            $scope.loans = response.data.data;
        });

    });
    // Edit Customer
    $scope.editSaveCustomer = function (customer) {
        $http.patch('/customer/api/updatecustomer', customer);
    };

    $scope.editCustomer =function(customer) {
        $scope.CustomerCopy = angular.copy(customer);
    };

    $scope.cancelEditCustomer = function() {
        $scope.customer = $scope.CustomerCopy;
    };

    // Edit Loan
    $scope.editLoan = function(loan) {
        $scope.loanEdit = loan;
    };
    // Class for loan
    $scope.redOrGreen = function (paid) {
        if (paid){
            return 'text-success';
        } else {
            return 'text-danger';
        }
    };
    // New Loan
    $scope.showNewLoanForm = false;
    $scope.newLoan = function () {
        $scope.showNewLoanForm = true;
    };
    $scope.cancelNewLoan = function () {
        $scope.getDates();
        $scope.showNewLoanForm = false;
    };
    $scope.submitNewLoan = function (newLoanObj) {
        newLoanObj.customer_id = $scope.customerId;
        $http.post('/loan/api/newloan', newLoanObj).then(function (response) {
            newLoanObj.id = response.data.loanId;
            $scope.loans.push(newLoanObj);
        });
        $scope.getDates();
        $scope.showNewLoanForm = false;
    }
}]);