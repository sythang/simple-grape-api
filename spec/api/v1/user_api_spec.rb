require 'rails_helper'

describe Api::V1::UserApi do
  include Rack::Test::Methods

  def app
    Api::Api
  end

  context "/api/v1/users/sign_in" do
    context "Invalid params" do

      context "Login without email & password" do
        it "return error message" do
          post '/api/v1/users/sign_in'
          expect(last_response.body).to eq({error: "email is missing, password is missing"}.to_json)
        end
      end

      context "Incorect password" do
        let!(:user) { create(:user, email: "julian@vinova.sg", password: "123456789")}
        it "return password is missing" do
          post '/api/v1/users/sign_in', { email: user.email, password: "123123123"}, 'Content-Type' => 'application/json'
          expect(last_response.body).to eq({error: "Invalid email or password"}.to_json)
          expect(last_response.status).to eq(401)
        end
      end

      context "Incorect password" do
        let!(:user) { create(:user, email: "julian@vinova.sg", password: "123456789")}
        it "return password is missing" do
          post '/api/v1/users/sign_in', { email: user.email, password: "123123123"}, 'Content-Type' => 'application/json'
          expect(last_response.body).to eq({error: "Invalid email or password"}.to_json)
          expect(last_response.status).to eq(401)
        end
      end

      context "Incorect email" do
        let!(:user) { create(:user, email: "julian@vinova.sg", password: "123456789")}
        it "return password is missing" do
          post '/api/v1/users/sign_in', { email: "abc@example", password: "123456789"}, 'Content-Type' => 'application/json'
          expect(last_response.body).to eq({error: "User not found"}.to_json)
          expect(last_response.status).to eq(500)
        end
      end
    end

    context "Valid params" do
      let!(:user) { create(:user, password: "12345678")}

      it "return login success" do
        post '/api/v1/users/sign_in', { email: user.email, password: "12345678"}, 'Content-Type' => 'application/json'
        expect(JSON.parse(last_response.body)["email"]).to eq(user.email)
        expect(last_response.status).to eq(201)
      end
    end
  end
end