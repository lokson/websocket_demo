controllers = angular.module 'controllers'
controllers.controller 'UsersController', ['$scope', '$resource',
  ($scope, $resource) ->
    User = $resource '/users', {format: 'json'}
    User.query null, (results) -> $scope.users = results
]