FactoryGirl.define do
  factory :item do
    name "item"
    description "description"
    image_url "https://pbs.twimg.com/profile_images/619573624903761920/EGZ2I6wG.jpg"
  end

  factory :user do
    name
    email
  end

  factory :order do
    amount 1000
    user
  end

  factory :order_item do
    order
    item
  end

  sequence :name do |n|
    "name#{n}"
  end

  sequence :email do |n|
    "email#{n}@gmail.com"
  end
end
