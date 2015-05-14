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
      templateUrl: (params) -> "#{root_path}users/#{params.id}/edit"
      controller: 'UserController'
    )
]

controllers = angular.module 'controllers', []

# todo: url helper like edit_users_path(1) => '#/users/{{user.id}}/edit'
