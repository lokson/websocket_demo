describe 'UsersController', ->
  scope = null
  httpBackend = null
  fixture.load 'users.json'
  users = fixture.json[0]

  setupController = ->
    inject ($rootScope, $httpBackend, $controller) ->
      scope = $rootScope.$new()
      httpBackend = $httpBackend
      $controller 'UsersController', $scope: scope
      httpBackend
        .expectGET new RegExp '\/users'
        .respond users

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'initialization', ->
    it 'gets from backend', ->
      module 'mi'
      setupController()
      httpBackend.flush()
      expect(angular.equals(scope.users, users)).toBeTruthy()
