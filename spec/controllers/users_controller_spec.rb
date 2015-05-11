require 'rails_helper'

describe UsersController do
  render_views

  describe 'index' do
    before do
      create_pair :user
      xhr :get, :index, format: :json
    end
    it 'should return two users' do
      results = JSON.parse response.body
      expect(results).to match pluck_to_hash(User, :name, :id)
    end
  end
end
