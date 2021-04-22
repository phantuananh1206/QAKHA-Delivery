class Admin::ExportPartnersController < ApplicationController
  def index
    @partners = Partner.order(:name)
    respond_to do |format|
	    format.xls { send_data @partners.to_xls }
	  end
  end
end
