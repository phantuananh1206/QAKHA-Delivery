class Admin::ExportDriversController < ApplicationController
  def index
    @drivers = Driver.order(:name)
    respond_to do |format|
	    format.xls { send_data @drivers.to_xls }
	  end
  end
end
