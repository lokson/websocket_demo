angular.module("mi")
.factory "User", ($resource) ->
  $resource "/users/:id",
    { id: "@id", format: 'json' },
    {
      'update': { method: 'PUT' }
      'create': { method: 'POST' }
      'delete': { method: 'DELETE' }
    }
