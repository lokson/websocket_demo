controllers = angular.module 'controllers'
controllers.controller 'UserController', ['$scope', '$resource',
  ($scope, $resource) ->
    root_path = $('#root_path').html()
    User = $resource "#{root_path}users", {format: 'json'}
    User.query null, (results) -> $scope.users = results
]