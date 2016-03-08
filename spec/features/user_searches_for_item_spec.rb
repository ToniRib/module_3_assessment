require "rails_helper"

RSpec.feature "User searches for item" do
  scenario "user searches for sennheiser from root path" do
    visit root_path

    fill_in "search", with: "sennheiser"
    click_on "search"

    expect(current_path).to eq(search_path)
    expect(page).to have_content("Results: 15")
  end
end
