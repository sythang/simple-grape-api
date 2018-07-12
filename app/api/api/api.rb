module Api
  class Api < Grape::API
    format :json
    version 'v1'
    prefix :api

    rescue_from ActiveRecord::RecordNotFound do |e|
      error!(e, 500)
    end

    helpers do
      def authorize_user!
        error!("Token Invalid", 400) unless headers["Access-Token"].present?
        error!("Unauthorize", 401) unless current_user
      end

      def current_user
        @current_user ||= User.find_by(token: headers["Access-Token"])
      end
    end

    rescue_from :all
    mount V1::ProductApi
    mount V1::UserApi

    add_swagger_documentation mount_path: '/swagger_doc'
  end
end