controllers = angular.module 'controllers'
controllers.controller 'UsersController', ['$scope', '$routeParams', 'User', '$state'
  ($scope, $routeParams, User, $state) ->

    # controller load
    $scope.load = ->
      $scope.users = User.query()
      $scope.user = User.get(id: $routeParams.id) if $routeParams.id

      # todo: set root_path and open websocket as separate services
      root_path = $('#root_path').html()
      if root_path == '/'
        $scope.wsoc = new WebSocketRails('localhost:3001/websocket')
      else
        $scope.wsoc = new WebSocketRails('kapustka.net:3001/websocket')

      # todo: store users extension as hash by id
      $scope.wsoc.bind 'users.create_success', (data) ->
        $scope.users.push(User.create data)

      $scope.wsoc.bind 'users.delete_success', (data) ->
        $scope.$apply ->
          $scope.users = $scope.users.filter (user) -> user.id != data.id

      $scope.wsoc.bind 'users.update_success', (data) ->
        $scope.$apply ->
          users = $scope.users.filter (user) -> user.id == data.id
          users[0].name = data.name

    # actions
    $scope.new = ->
      $scope.user = null
      $state.go('users.new')

    $scope.edit = (user) ->
      $scope.user = user
      $state.go('users.edit', id:user.id)

    $scope.save = (user) ->
      if user.id
        $scope.wsoc.trigger('users.update',user)
      else
        $scope.wsoc.trigger('users.create',user)
      $state.go('users')

    $scope.delete = (user) ->
      $scope.wsoc.trigger('users.delete',user)
      $state.go('users')

    $scope.load()
]


#  $scope.$apply ->
#    $scope.users = $scope.users.map (user) ->
#      if user.id == data.id
#        data
#      else
#        user

# previous delete:
#      User.delete(user)
#      i = $scope.users.indexOf(user)
#      $scope.users.splice(i,1)

# previous create:
#        User.create user
#        $scope.users.push(user)

# update:
#  User.update(user)


# for debug
#      $scope.wsoc.on_open = ->
#        console.log 'on open'
#      $scope.wsoc.on_message = (e) ->
#        console.log "on message #{e.data}"
#      $scope.wsoc.on_error = (e) ->
#        console.log "on error #{e.data}"
#      $scope.wsoc.on_close = (e) ->
#        console.log 'on close'




# $scope (it was not updating, use $scope.$apply = function ...
#          i = $scope.users.map((e) -> e.id).indexOf(data.id)
#          $scope.users.splice(i,1)
#        $scope.users
#        arr = $scope.users.filter (user) ->
#          user.id != data.id
#        console.log "arr = #{arr}"
#        $scope.users = arr
#        temp = for user in $scope.users when user.id != data.id
#          console.log "user.id: #{user.id}"
#          console.log "data.id: #{data.id}"
#          console.log '----'
#          user
#        $scope.users= temp



# websocket instead of WebSocketRails
#  conn = new WebSocket('ws://localhost:3000/websocket')
#  conn.onopen = ->
#    console.log 'on open'
#  conn.onmessage = (e) ->
#    console.log "on message #{e.data}"
#  conn.onerror = (e) ->
#    console.log "on error #{e.data}"
#  conn.onclose = (e) ->
#    console.log 'on close'
#
#  $scope.new = ->
#    conn.send("users.create")


# websocket instead of WebSocketRails
#var conn = new WebSocket('ws://echo.websocket.org/');
#// The action fired when you're successfully connected to a Websocket
#conn.onopen = function(e) {
#console.log("Connection established!");
#};
#// This function catches all the incoming messages
#conn.onmessage = function(e) {
#console.log('New message: ' + e.data);
#document.querySelector('#messages').innerHTML += '&lt;li&gt;' + e.data + '&lt;/li&gt;';
#};
#// This one catches all the errors
#conn.onerror = function(e) {
#console.log('Error: ' + e.data);
#};
#// And finally this function catches the successful disconnection
#conn.onclose = function(e) {
#console.log('Disconnected');
#};
#// A little event to send the current message
#document.querySelector('button#fire').onclick = function() {
#conn.send(document.querySelector('#send').value);
#document.querySelector('#send').value = '';
#};






#dispatcher = new WebSocketRails('localhost:3000/websocket')
#
#dispatcher.on_open = ->
#  console.log 'on open'
#  dispatcher.trigger('new_user',{user_name: 'guest'});
#  dispatcher.trigger('wrong',{user_name: 'guest'});
#
#dispatcher.bind 'users.create_success', (user) ->
#  console.log('successfully created ' + user.name);



#      $scope.dispatcher = new WebSocketRails('localhost:3000/websocket')
##      $scope.dispatcher = new WebSocketRails('kapustka.net/mi/websocket')
#      $scope.dispatcher.bind 'users.create_success', (user) ->
#        console.log('successfully created ' + user.name);
#        $scope.users.push(User.create user)

#        $scope.dispatcher.trigger('users.create', user)



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