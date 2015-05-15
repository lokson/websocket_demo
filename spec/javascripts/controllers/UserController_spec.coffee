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

  beforeEach ->
    module 'mi'
    setupController(true, user.id)
    httpBackend.flush()

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'initialization', ->
    it 'loads users from backend', ->
      # todo: custom matcher
      expect(angular.equals(scope.user, user)).toBeTruthy()
