require 'rails_helper'

describe UsersController do
  render_views

  describe 'index' do
    before do
      create_pair :user
      xhr :get, :index, format: :json
    end
    it('should return two records') do
      expect(json_parse response.body).to match pluck_to_hash(User, :name, :id)
    end
    it_should_behave_like :ok_page
  end

  describe 'edit' do
    before do
      user = create :user
      get :edit, id: user.id
    end
    it_should_behave_like :ok_page
  end

  describe 'update' do
    let :changes do
      attributes_for :user
    end
    before do
      user = create :user
      xhr :put, :update, id: user.id, user: changes, format: :json
    end
    it('should change record') do
      expect(User.only).to have_attributes changes
    end
    it('should return changed record') do
      expect(json_parse response.body).to include changes
    end
    it_should_behave_like :ok_page
  end
end
