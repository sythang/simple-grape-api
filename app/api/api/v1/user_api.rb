module Api::V1
  class UserApi < Grape::API
    namespace :users do
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post :sign_in do
        user = User.find_by(email: params[:email])
        raise ActiveRecord::RecordNotFound.new("User not found") unless user
        if user.valid_password?(params[:password])
          present user
        else
          error!("Invalid email or password", 401)
        end
      end

      params do
        requires :email, type: String
        requires :password, type: String
      end
      post :sign_up do
        present User.create!(declared(params))
      end
    end
  end
end