mi = angular.module 'mi', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive',
  'ngAnimate',
]

mi.config ['$routeProvider', 'flashProvider'
  ($routeProvider, flashProvider) ->
    flashProvider.errorClassnames.push 'alert-danger'
    flashProvider.warnClassnames.push 'alert-warning'
    flashProvider.infoClassnames.push 'alert-info'
    flashProvider.successClassnames.push 'alert-success'

    $routeProvider
    .when('/',
      templateUrl: 'index.html'
      controller: 'UsersController'
    )
]

controllers = angular.module 'controllers', []
