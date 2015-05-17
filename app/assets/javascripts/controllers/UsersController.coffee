controllers = angular.module 'controllers'
controllers.controller 'UsersController', ['$scope', '$routeParams', 'User', '$state'
  ($scope, $routeParams, User, $state) ->
    $scope.load = ->
      $scope.users = User.query()
      if $routeParams.id
        $scope.user = User.get(id: $routeParams.id)
#      $scope.dispatcher = new WebSocketRails('localhost:3000/websocket')
      $scope.dispatcher = new WebSocketRails('kapustka.net/mi/websocket')
      $scope.dispatcher.bind 'users.create_success', (user) ->
        console.log('successfully created ' + user.name);
        $scope.users.push(User.create user)

    $scope.new = ->
      $scope.user = null
      $state.go('users.new')

    $scope.edit = (user) ->
      $scope.user = user
      $state.go('users.edit', id:user.id)

    $scope.save = (user) ->
      if user.id
        User.update(user)
      else
        $scope.dispatcher.trigger('users.create', user)
#        $scope.users.push(User.create user)
      $state.go('users')

    $scope.delete = (user) ->
      User.delete(user)
      i = $scope.users.indexOf(user)
      $scope.users.splice(i,1)
      $state.go('users')

    $scope.load()
]


#task =
#  name: 'Start taking advantage of WebSockets'
#  completed: false
#dispatcher = new WebSocketRails('localhost:3000/websocket')
#dispatcher.trigger('tasks.create', task)



#var task = {
#  name: 'Start taking advantage of WebSockets',
#  completed: false
#}
#
#var dispatcher = new WebSocketRails('localhost:3000/websocket');
#
#dispatcher.trigger('tasks.create', task);