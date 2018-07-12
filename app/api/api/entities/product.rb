module Api::Entities
  class Product < Grape::Entity
    root 'products'
    expose :title
    expose :description
    expose :price
    expose :price, as: :price_usd do |instance, options|
      "#{instance.price} USD"
    end
  end
end