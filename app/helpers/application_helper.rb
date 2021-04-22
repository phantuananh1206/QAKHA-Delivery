module ApplicationHelper
  def full_title page_title = ""
    base_title = "QAKHA-DELIVERY"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def number_to_currency_vnd(number)
    number_to_currency(number, :unit => "vnđ", :delimiter => ".", format: "%n %u")
  end
end
