controllers = angular.module 'controllers'
controllers.controller 'UsersController', ['$scope', '$routeParams', 'User', '$state'
  ($scope, $routeParams, User, $state) ->
    $scope.load = ->
      $scope.users = User.query()
      if $routeParams.id
        $scope.user = User.get(id: $routeParams.id)

    $scope.new = ->
      $scope.user = null
      $state.go 'users.new'

    $scope.edit = (user) ->
      $state.go('users.edit', id:user.id)
      .then -> $scope.user = user

    $scope.save = (user) ->
      if user.id
        User.update user
      else
        $scope.users.push(User.create user)
      $state.go 'users'

    $scope.delete = (user) ->
      User.delete user
      i = $scope.users.indexOf(user)
      $scope.users.splice(i,1)
      $state.go 'users'

    $scope.load()
]
