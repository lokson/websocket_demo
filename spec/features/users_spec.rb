require 'spec_helper.rb'

feature 'users', js: true do
  before do
    create_pair :user
  end

  scenario 'view users' do
    visit '/'
    expect(page).to have_content User.first.name
    expect(page).to have_content User.second.name

    fill_in "keywords", with: User.first.name
    expect(page).not_to have_content User.second.name

    click_on User.first.name
    expect(page).to have_content User.first.name
  end
end