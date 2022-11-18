class HeartbeatController < ApplicationController
  def index
    render json: {
      code: 200,
      message: 'Successful ping.'
    }, status: :ok
  end
end