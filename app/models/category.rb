class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy
  has_many :products_categories, dependent: :destroy
  has_many :products, :through => :products_categories
end
