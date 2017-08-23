class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token

  def current_user
    @user ||= User.find_by(api_key: api_key) unless api_key.nil?
  end

  def api_key
    match = request.headers['AUTHORIZATION']&.match(/^Apikey (.+)/)
    match&.length == 2 ? match[1] : nil
  end

  def authenticate_user!
    head :unauthorized unless current_user.present?
  end

end
