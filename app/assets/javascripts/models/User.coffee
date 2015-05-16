angular.module("mi")
.factory "User", ($resource) ->
  root_path = $('#root_path').html()
  $resource "#{root_path}users/:id",
    { id: "@id", format: 'json' },
    {
      'update': { method: 'PUT' }
      'create': { method: 'POST' }
      'delete': { method: 'DELETE' }
    }
