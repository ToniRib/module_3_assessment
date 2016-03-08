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
    expect(page).to have_css("img[src*='#{image_path}']")

    expect(page).to have_css(".product", count: 15)
    expect(page).to have_css(".product-name", count: 15)
    expect(page).to have_css(".product-sku", count: 15)
    expect(page).to have_css(".product-short-description", count: 15)
    expect(page).to have_css(".product-image", count: 15)
    expect(page).to have_css(".product-review", count: 15)
    expect(page).to have_css(".product-sale-price", count: 15)
  end

  scenario "user searches for sennheiser headphones white from root path" do
    visit root_path

    VCR.use_cassette("search_sennheiser_white_headphones") do
      fill_in "search", with: "sennheiser headphones white"
      click_on "search"
    end

    expect(current_path).to eq(search_path)
    expect(page).to have_content("Results: 3")
    expect(page).to have_content("SKU: 9068155")
    expect(page).to have_content("SKU: 9068004")
    expect(page).to have_content("SKU: 9068128")
    expect(page).to have_css(".product", count: 3)
    expect(page).to have_css(".product-name", count: 3)
    expect(page).to have_css(".product-sku", count: 3)
    expect(page).to have_css(".product-short-description", count: 3)
    expect(page).to have_css(".product-image", count: 3)
    expect(page).to have_css(".product-review", count: 3)
    expect(page).to have_css(".product-sale-price", count: 3)

    within ".product:nth-child(1)" do
      expect(page).to have_content("Sennheiser - CX 2.00G Earbud Headphones - White")
      expect(page).to have_content("SENNHEISER CX 2.00G Earbud Headphones: Dynamic transducers; 3-button in-line remote with integrated microphone; 4 ear adapter sizes; 3.9' cable; 3.5mm angled plug")
      expect(page).to have_content("Customer Review Average: 1.0")
      expect(page).to have_content("Sale Price: $54.95")
      expect(page).to have_css("img[src*='http://images.bestbuy.com/BestBuy_US/images/products/9068/9068155_sa.jpg']")
    end

    within ".product:nth-child(2)" do
      expect(page).to have_content("Sennheiser - CX 3.00 Earbud Headphones - White")
      expect(page).to have_content("SENNHEISER CX 3.00 Earbud Headphones: Dynamic transducers; 4 ear adapter sizes; 3.9' elliptical, tangle-free cable; 3.5mm angled plug; includes a carrying case")
      expect(page).to have_content("Customer Review Average: 3.5")
      expect(page).to have_content("Sale Price: $45.99")
      expect(page).to have_css("img[src*='http://images.bestbuy.com/BestBuy_US/images/products/9068/9068004_sa.jpg']")
    end

    within ".product:nth-child(3)" do
      expect(page).to have_content("Sennheiser - CX 5.00i Earbud Headphones - White")
      expect(page).to have_content("SENNHEISER CX 5.00i Earbud Headphones: Dynamic transducers; 3-button in-line remote with integrated omnidirectional microphone; ergonomic, angled design; 4 ear adapter sizes; 3.9' elliptical, tangle-free cable; 3.5mm angled plug")
      expect(page).to have_content("Customer Review Average: 2.0")
      expect(page).to have_content("Sale Price: $89.95")
      expect(page).to have_css("img[src*='http://images.bestbuy.com/BestBuy_US/images/products/9068/9068128_sa.jpg']")
    end
  end

  scenario "search returns no products" do
    visit root_path

    VCR.use_cassette("search_toni_rib") do
      fill_in "search", with: "toni rib"
      click_on "search"
    end

    expect(current_path).to eq(search_path)
    expect(page).to have_content("No products were found for that search term")
    expect(page).to have_content("Results: 0")
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

  def image_path
    "http://images.bestbuy.com/BestBuy_US/images/products/9068/9068146_sa.jpg"
  end
end
