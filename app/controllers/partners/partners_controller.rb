class Partners::PartnersController < ApplicationController
  layout "layouts/partner"
  # before_action :authenticate_partner!
  before_action :check_sign_in

  def index
    @partner = current_partner
  end
end
