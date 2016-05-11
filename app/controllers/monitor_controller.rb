class MonitorController < ActionController::API

  def index
    head 200
  end

  def ping
    render json: 'pong'
  end
end