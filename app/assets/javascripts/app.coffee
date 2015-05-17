mi = angular.module 'mi', [
  'ngRoute',
  'ngResource',
  'ngAnimate',
  'ui.router',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive',
]

mi.config ['flashProvider', '$stateProvider', '$urlRouterProvider'
  (flashProvider, $stateProvider, $urlRouterProvider) ->
    flashProvider.errorClassnames.push 'alert-danger'
    flashProvider.warnClassnames.push 'alert-warning'
    flashProvider.infoClassnames.push 'alert-info'
    flashProvider.successClassnames.push 'alert-success'

    root_path = $('#root_path').html()

    $urlRouterProvider.otherwise("/users");
    $stateProvider
      .state('users',
        url: '/users'
        templateUrl: "#{root_path}users"
        controller: 'UsersController'
      ).state('users.new',
        url: '/new'
        templateUrl: "#{root_path}users/new"
      ).state('users.edit',
        url: '/:id/edit'
        templateUrl: (params) -> "#{root_path}users/#{params.id}/edit"
      )
]

controllers = angular.module 'controllers', []
