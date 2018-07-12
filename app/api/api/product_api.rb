module Api
  class ProductApi < Grape::API
    
    namespace :admin do
      get :products do
        Product.all
      end
    end
    
  end
end