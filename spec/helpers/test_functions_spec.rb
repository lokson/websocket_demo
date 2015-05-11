require 'spec_helper'

describe 'pluck to hash' do
  context 'with model and columns' do
    before do
      create_pair :user
    end
    it 'should return hash' do
      expected = [
        {'id' => User.first.id, 'name' => User.first.name},
        {'id' => User.second.id, 'name' => User.second.name}
      ]
      actual = pluck_to_hash User, :name, :id
      expect(actual).to eq expected
    end
  end
end

describe 'json fixtures' do
  let(:users) { build_pair :user }

  context 'with data and columns' do
    it 'should return json' do
      expected = [
        {'name' => users.first.name},
        {'name' => users.second.name}
      ].to_json
      actual = json_fixtures data: users, columns: [:name]
      expect(actual).to eq expected
    end
  end

  context 'with data and _id column' do
    it 'should return json and generate id' do
      expected = [
        {'name' => users.first.name, 'id' => 1},
        {'name' => users.second.name, 'id' => 2}
      ].to_json
      actual = json_fixtures data: users, columns: [:name], generate_id: true
      expect(actual).to eq expected
    end
  end
end