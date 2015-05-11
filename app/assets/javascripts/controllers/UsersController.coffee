controllers = angular.module 'controllers'
controllers.controller 'UsersController', [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource) ->
    User = $resource '/users', { format: 'json' }
    User.query null, (results) -> $scope.users = results
]