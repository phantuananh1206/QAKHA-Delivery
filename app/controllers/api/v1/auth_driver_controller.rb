class Api::V1::AuthDriverController < Api::V1::ApplicationController
  def initialize(headers = {})
    @headers = headers
  end

  def authenticate_request!
    verify_token
  end

  private

  def http_token
    if @headers['Authorization'].present?
      @headers['Authorization'].split(' ').last
    end
  end

  def verify_token
    @driver ||= Driver.find(JsonWebToken.decode(http_token)[:id]) if JsonWebToken.decode(http_token)
  end
end
