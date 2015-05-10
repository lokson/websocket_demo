require 'spec_helper.rb'

feature "Users", js: true do
  before do
    User.create!(name: 'Bronisław Komorowski')
    User.create!(name: 'Andrzej Duda')
  end

  scenario "view users" do
    visit '/'
    expect(page).to have_content('Bronisław Komorowski')
    expect(page).to have_content('Andrzej Duda')
  end
end