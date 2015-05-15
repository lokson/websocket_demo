controllers = angular.module 'controllers'
controllers.controller 'UserController', ['$scope', '$resource', '$routeParams'
  ($scope, $resource, $routeParams) ->
    root_path = $('#root_path').html() ? '/'

    User = $resource "#{root_path}users/:id", { format: 'json' }
    if $routeParams.id
      User.get
        id: $routeParams.id
        (user) -> $scope.user = user
]