require 'spec_helper'

describe UsersController do
  render_views
  describe "index" do
    before do
      User.create!(name: 'Bronisław Komorowski')
      User.create!(name: 'Andrzej Duda')
      xhr :get, :index, format: :json
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_name
      ->(object) { object["name"] }
    end

    it 'should return two results' do
      expect(results.size).to eq(2)
    end
    it "should include 'Bronisław Komorowski'" do
      expect(results.map(&extract_name)).to include('Bronisław Komorowski')
    end
    it "should include 'Andrezj Duda'" do
      expect(results.map(&extract_name)).to include('Andrzej Duda')
    end
  end
end
