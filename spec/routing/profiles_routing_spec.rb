require "rails_helper"

RSpec.describe ProfilesController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/profile").to route_to("profiles#show")
    end

    it "routes to #create" do
      expect(post: "/profiles").to route_to("profiles#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/profiles/").to route_to("profiles#update")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/profiles/").to route_to("profiles#update")
    end
  end
end
