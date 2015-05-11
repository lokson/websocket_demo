require 'spec_helper.rb'

feature 'users', js: true do
  before do
    create_pair :user
  end

  scenario 'view users' do
    visit '/'
    expect(page).to have_content User.first.name
    expect(page).to have_content User.second.name
  end
end