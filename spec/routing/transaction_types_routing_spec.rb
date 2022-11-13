require "rails_helper"

RSpec.describe TransactionTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/transaction_types").to route_to("transaction_types#index")
    end

    it "routes to #show" do
      expect(get: "/transaction_types/1").to route_to("transaction_types#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/transaction_types").to route_to("transaction_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/transaction_types/1").to route_to("transaction_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/transaction_types/1").to route_to("transaction_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/transaction_types/1").to route_to("transaction_types#destroy", id: "1")
    end
  end
end
