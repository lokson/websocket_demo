mi = angular.module 'mi', [
  'ngRoute',
  'ngResource',
  'ngAnimate',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive',
]

mi.config ['$routeProvider', 'flashProvider'
  ($routeProvider, flashProvider) ->
    flashProvider.errorClassnames.push 'alert-danger'
    flashProvider.warnClassnames.push 'alert-warning'
    flashProvider.infoClassnames.push 'alert-info'
    flashProvider.successClassnames.push 'alert-success'

    $routeProvider
    .when('/',
      templateUrl: 'users'
      controller: 'UsersController'
    ).when('/users/new',
      templateUrl: "form.html"
      controller: 'UserController'
    ).when('/users/:recipeId/edit',
      templateUrl: "form.html"
      controller: 'UserController'
    )
]

controllers = angular.module 'controllers', []
