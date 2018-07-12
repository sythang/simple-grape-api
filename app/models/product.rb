class Product < ApplicationRecord
  validates_presence_of :title, :description, :price
end
