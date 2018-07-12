module Api::V1
  class ProductApi < Grape::API
    helpers do
      def product
        @product ||= Product.find(params[:id])
      end
    end
    before do
      # validate token
      # 686cc1da4dbf6a16ef1e
      authorize_user!
    end
    resources :products do
      get do
        present Product.all, with: Api::Entities::Product
      end

      get ":id" do
        present Product.find(params[:id]), with: Api::Entities::Product
      end

      # post /products

      params do
        requires :title, type: String
        optional :description, type: String
        requires :price, type: Float
      end
      post do
        # require logged in 
        Product.create!(declared(params))
      end


      params do
        requires :title, type: String
        optional :description, type: String
        requires :price, type: Float
      end
      put ":id" do
        product.update_attributes(declared(params))
        present product
      end

      delete ":id" do
        product.destroy
        present "Destroyed"
      end
    end
    
  end
end