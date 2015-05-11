describe 'UsersController', ->
  scope = null
  httpBackend = null
  fixture.load 'users.json'
  users = fixture.json[0]

  setupController = ->
    inject ($location, $rootScope, $httpBackend, $controller) ->
      scope = $rootScope.$new()
      location = $location
      httpBackend = $httpBackend
      httpBackend.expectGET(new RegExp('\/users')).respond users
      $controller 'UsersController', $scope: scope, $location: location

  beforeEach ->
    module 'mi'
    setupController()
    httpBackend.flush()

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'initialization', ->
    it 'loads users from backend', ->
      expect(angular.equals(scope.users, users)).toBeTruthy()
