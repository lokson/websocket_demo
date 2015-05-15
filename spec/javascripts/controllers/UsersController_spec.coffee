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
      httpBackend.expectGET(new RegExp('\/users')).respond users

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
