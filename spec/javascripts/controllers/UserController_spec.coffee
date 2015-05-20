describe 'UserController', ->
  scope = null
  httpBackend = null
  fixture.load 'users.json'
  user = fixture.json[0][0]

  setupController = (exists, id)->
    inject ($rootScope, $httpBackend, $controller, $routeParams) ->
      scope = $rootScope.$new()
      httpBackend = $httpBackend

      if id
        $routeParams.id = id
        results = if exists
          [200, user]
        else
          [404]
        httpBackend
          .expectGET(new RegExp("\/users/#{id}"))
          .respond results[0], results[1]

      $controller 'UserController', $scope: scope

  afterEach ->
#    httpBackend.verifyNoOutstandingExpectation()
#    httpBackend.verifyNoOutstandingRequest()

  describe 'initialization', ->
    beforeEach ->
      module 'mi'
      setupController(true, user.id)
      httpBackend.flush()

    it 'gets from backend', ->
      # todo: custom matcher
      expect(angular.equals(scope.user, user)).toBeTruthy()

  describe 'update', ->
    it 'puts to backend', ->
      # todo: use factories here
      changes =
        name: 'Luke Changed'
        id: user.id

      module 'mi'
      setupController(true, user.id)

      scope.user = changes
      httpBackend.flush()
      scope.save()
      httpBackend
        .expectPUT new RegExp "\/users"
        .respond 200, changes










#    describe 'update', ->
#      updatedRecipe =
#        name: 'Toast'
#        instructions: 'put in toaster, push lever, add butter'
#      beforeEach ->
#        setupController()
#        httpBackend.flush()
#        request = new RegExp("\/recipes")
#        httpBackend.expectPUT(request).respond(204)
#      it 'posts to the backend', ->
#        scope.recipe.name = updatedRecipe.name
#        scope.recipe.instructions = updatedRecipe.instructions
#        scope.save()
#        httpBackend.flush()
#        expect(location.path()).toBe("/recipes/#{scope.recipe.id}")
