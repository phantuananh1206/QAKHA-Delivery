class Admin::StatisticsPartnersController < Admin::BaseController
  def statistics_by_month
    respond_to do |format|
      format.js
      format.html
     end
  end

  def statistics_by_quarter
    respond_to do |format|
      format.js
      format.html
     end
  end

  def statistics_by_year
    respond_to do |format|
      format.js
      format.html
     end
  end
end
