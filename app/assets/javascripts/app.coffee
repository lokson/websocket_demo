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

    root_path = $('#root_path').html()

    $routeProvider
    .when("/",
      templateUrl: "#{root_path}users"
      controller: 'UsersController'
    ).when("/users/new",
      templateUrl: "#{root_path}users/new"
      controller: 'UserController'
    ).when("/users/:id/edit",
      # todo: change to id
      # todo: read how to access id
      templateUrl: "#{root_path}users/1/edit"
      controller: 'UserController'
    )
]

controllers = angular.module 'controllers', []
