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
    expect(page).to have_content(product_sku)
    expect(page).to have_content(customer_review_average)
  end

  def product_name
    "Sennheiser - CX 1.00 Earbud Headphones - Black"
  end

  def product_description
    "SENNHEISER CX 1.00 Earbud Headphones: Noise-blocking design; " \
    "dynamic transducer principle; ultrasmall design; 3.5mm connector;" \
    " 3.9' cable; includes 4 sizes of ear adapters"
  end

  def product_sku
    "SKU: 9068146"
  end

  def customer_review_average
    "Customer Review Average: 5.0"
  end

  def sale_price
    "Sale Price: $44.95"
  end
end
