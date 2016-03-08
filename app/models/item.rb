class Item < ActiveRecord::Base
  has_many :order_items
  has_many :orders, through: :order_items

  default_scope { order(id: :asc) }
end
