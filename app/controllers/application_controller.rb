class ApplicationController < ActionController::API
  include Pundit::Authorization
  include RackSessionFixController
  # before_action :authenticate_user!
end
