require 'rails_helper'

RSpec.describe "Schemas", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/schemas/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/schemas/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/schemas/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/schemas/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
