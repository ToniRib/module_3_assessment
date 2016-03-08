require "rails_helper"

RSpec.feature "User searches for item" do
  scenario "user searches for sennheiser from root path" do
    visit root_path

    VCR.use_cassette("search_sennheiser") do
      fill_in "search", with: "sennheiser"
      click_on "search"
    end

    expect(current_path).to eq(search_path)
    expect(page).to have_content("Results: 15")

    expect(page).to have_content(product_name)
    expect(page).to have_content(product_description)
  end

  def product_name
    "Sennheiser - Camera-Mount Wireless Microphone System - Black"
  end

  def product_description
    "SENNHEISER Camera-Mount Wireless Microphone System: " \
    "Invisible clip-on microphone; sturdy metal housing; " \
    "automatic frequency management; easy-to-read illuminated" \
    " display; 4-level battery indicator; 626-668MHz frequency range"
  end
end
