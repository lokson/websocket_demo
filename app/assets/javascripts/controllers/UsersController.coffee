controllers = angular.module 'controllers'
controllers.controller 'UsersController', ['$scope', '$routeParams', 'User', '$state'
  ($scope, $routeParams, User, $state) ->
    $scope.load = ->
      $scope.users = User.query()
      if $routeParams.id
        $scope.user = User.get(id: $routeParams.id)

#    $scope.new = ->
#      $scope.user = null
#      $state.go('users.new')

    $scope.edit = (user) ->
      $scope.user = user
      $state.go('users.edit', id:user.id)

    $scope.save = (user) ->
      if user.id
        User.update(user)
      else
        $scope.users.push(User.create user)
      $state.go('users')

    $scope.delete = (user) ->
      User.delete(user)
      i = $scope.users.indexOf(user)
      $scope.users.splice(i,1)
      $state.go('users')

    $scope.load()

    root_path = $('#root_path').html()
    if root_path = '/'
      conn = new WebSocketRails('localhost:3001/websocket')
    else
      conn = new WebSocketRails('kapustka.net:3001/websocket')
    conn.on_open = ->
      console.log 'on open'
    conn.on_message = (e) ->
      console.log "on message #{e.data}"
    conn.on_error = (e) ->
      console.log "on error #{e.data}"
    conn.on_close = (e) ->
      console.log 'on close'

    $scope.new = ->
      console.log 'new clicked'
      console.log conn.trigger('users.new',{name: 'guest'});

    conn.bind 'users.create_success', (user) ->
      $scope.users.push(User.create user)
#      console.log('successfully created ' + user.name);
]


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