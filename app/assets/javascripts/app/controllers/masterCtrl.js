'use strict';
var app = angular.module('gerenciamento');

app.controller("masterCtrl", ["$scope", "$http", "$log", function ($scope, $http, $log) {
    $scope.customers = [];
    $scope.loans = [];
    var primeiro = true;
    // Loading customers and loans
    $http.get("/customer/angular/json").then(function (response) {
        $scope.customers = response.data.data;
        $scope.customers.forEach(function (customer) {
            customer.vlrReceber = 0.0;

            $http.get("/loan/angular/json").then(function (response) {
                $scope.loans = response.data.data;
                if (primeiro){
                    primeiro = false;
                    $scope.loans.forEach(function (loan) {
                        var total = 0;
                        if (loan.paid_p1 == false) {
                            total += loan.portion1;
                        }
                        if (loan.paid_p2 == false) {
                            total += loan.portion3;
                        }
                        if (loan.paid_p3 == false) {
                            total += loan.portion3;
                        }
                        $scope.customers.forEach(function (customer) {
                            if (customer.id == loan.customer_id) {
                                customer.vlrReceber += total;
                            }
                        })
                    })
                }
            })
        })
    });
    // Creating New Customer
    $scope.addCustomer = function (customer) {
        $http.post("/customer/api/createcustomer", customer).then(function (response) {
            customer.vlrReceber = 0;
            customer.id = response.data.data;
            $scope.customers.push(angular.copy(customer));
            delete $scope.customer;
        });
        
    }
}]);