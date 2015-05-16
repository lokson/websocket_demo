controllers = angular.module 'controllers'
controllers.controller 'UsersController', ['$scope', '$resource', '$routeParams', '$location', 'User', '$state'
  ($scope, $resource, $routeParams, $location, User, $state) ->
    $scope.load = ->
      $scope.users = User.query()
      if $routeParams.id
        $scope.user = User.get(id: $routeParams.id)

    $scope.new = ->
      $scope.user = null
      $state.go 'users.new'

    $scope.edit = (user) ->
      $scope.user = user
      $state.go 'users.edit', id:user.id

    $scope.save = (user) ->
      if user.id
        User.update user
      else
        User.create user
      $state.go 'users'
      $scope.load()

    $scope.delete = (user) ->
      User.delete user
      $state.go 'users'
      $scope.load()

    $scope.load()
]
