'use strict';
var app = angular.module('gerenciamento');

app.controller("customerIndexCtrl", ["$scope", "$http", "$log", "$location", function ($scope, $http, $log, $location) {
    $scope.customers = [];
    $scope.loans = [];
    $scope.showForm = false;
    $scope.search = "";
    $scope.page = 0;
    var primeiro = true;
    // Loading customers and loans
    $http.get("/customer/angular/json").then(function (response) {
        $scope.customers = response.data.data;
        return
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
    // Behavior of Form
    $scope.showFormFunction = function() {
        $scope.showForm = true;
    }
    $scope.cancelAddCustomer = function() {
        $scope.showForm = false;
        delete $scope.customer;
    }
    // Creating New Customer
    $scope.addCustomer = function (customer) {
        $http.post("/customer/api/createcustomer", customer).then(function (response) {
            customer.vlrReceber = 0;
            customer.id = response.data.data;
            $scope.customers.unshift(angular.copy(customer));
            delete $scope.customer;
            $scope.showForm = false;
        });
    };

    // Edit Form
    $scope.editCustomer = function (customer) {
        $scope.customerEdit = angular.copy(customer);
    };
    $scope.editSaveCustomer = function (customerEdit) {
        $http.patch('/customer/api/updatecustomer', customerEdit);
        $scope.customers.forEach(function (customer, customerIndex) {
            if (customer.id == customerEdit.id) {
                $scope.customers[customerIndex] = customerEdit;
            }
        })
    };
    $scope.cancelEditCustomer = function () {
        delete $scope.customerEdit;
    }

    // Keypress
    $scope.helloWorld = function () {
        console.log($scope.search)
        if ($scope.search.length > 4) {
            $http.get("/customer/angular/json?name=" + $scope.search).then(function (response) {
                $scope.customers = response.data.data;
                return
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
        } else {
            $http.get("/customer/angular/json").then(function (response) {
                $scope.customers = response.data.data;
                return
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
        }
    }
    $scope.nextPage = function () {
        $scope.page += 1;
        $http.get("/customer/angular/json?page=" + $scope.page).then(function (response) {
            $scope.customers = response.data.data;
            return
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
    }
    $scope.prevPage = function () {
        if ($scope.page > 0 ) {
            $scope.page -= 1;
            $http.get("/customer/angular/json?page=" + $scope.page).then(function (response) {
                $scope.customers = response.data.data;
                return
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
        }
    }
}]);