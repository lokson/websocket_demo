describe 'UsersController', ->
  scope = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null
  httpBackend  = null

  users = [
    {
      id: 2
      name: 'Bronisław Komorowski'
    },
    {
      id: 4
      name: 'Andrzej Duda'
    }
  ]

  setupController = ->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      httpBackend = $httpBackend

      request = new RegExp("\/users")
      httpBackend.expectGET(request).respond(users)

      ctrl = $controller('UsersController',
        $scope: scope
        $location: location)
    )

  beforeEach(module("mi"))
  beforeEach(setupController())
  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'index', ->
    it 'loads users from backend', ->
      httpBackend.flush()
      expect(angular.equals(scope.users, users)).toBeTruthy()

