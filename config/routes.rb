Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Api::Api => "/"
  mount GrapeSwaggerRails::Engine => '/documentation'

end
