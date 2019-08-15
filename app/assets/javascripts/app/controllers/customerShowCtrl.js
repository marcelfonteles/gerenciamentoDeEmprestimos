'use strict';
var app = angular.module("gerenciamento")

app.controller("customerShowCtrl", ["$scope", "$location", "$log", "$http", function ($scope, $location, $log, $http) {
    $scope.customerId = $location.absUrl().substring($location.absUrl().lastIndexOf("/")+1, $location.absUrl().length);
    $scope.customer = [];
    $scope.loans = [];

    $http.get('/customer/api/getcustomer/'+$scope.customerId).then(function (response) {
        $scope.customer = response.data.data;

        $http.get('/loan/api/getcustomerloans/'+$scope.customerId).then(function (response) {
            $scope.loans = response.data.data;
            $log.log($scope.loans);
        });
    });

    $scope.editSaveCustomer = function (customer) {
        $http.patch('/customer/api/updatecustomer', customer);
    };

    $scope.editCustomer =function(customer) {
        $scope.CustomerCopy = angular.copy(customer);
    }

    $scope.cancelEditCustomer = function() {
        $scope.customer = $scope.CustomerCopy;
    }
    $scope.redOrGreen = function (paid) {
        if (paid == 'true'){
            return 'text-success';
        } else {
            return 'text-danger';
        }

    }
}]);