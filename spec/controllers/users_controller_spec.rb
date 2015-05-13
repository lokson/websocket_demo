require 'rails_helper'

describe UsersController do
  render_views

  describe 'index' do
    before do
      create_pair :user
      xhr :get, :index, format: :json
    end
    it_should_behave_like :ok_page
    it 'should return two records' do
      results = JSON.parse response.body
      expect(results).to match pluck_to_hash(User, :name, :id)
    end
  end

  describe 'update' do
    let :changes do
      attributes_for :user
    end
    before do
      user = create :user
      xhr :put, :update, id: user.id, user: changes, format: :json
    end
    # it 'should change record' do
    #   expect(User.only)
    # end
    it 'should return changed record' do
      expect(response.status).to eq 200
      expect(json_parse response.body).to include changes
    end
  end
end
