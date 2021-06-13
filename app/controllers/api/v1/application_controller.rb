class Api::V1::ApplicationController < ActionController::API
  respond_to :json

  before_action :load_partners, :load_voucher
  before_action :auto_clear_cart

  def load_partners
    @partners = Partner.all
    @partners.each do |partner|
      if Time.zone.now.strftime('%H:%M') >= partner.time_close.strftime('%H:%M') && partner.open?
        partner.update_columns(status: :close)
      end
    end
  end

  def load_voucher
    @vouchers = Voucher.all
    @vouchers.each do |voucher|
      if Time.zone.now >= voucher.expiry_date && voucher.effective?
        voucher.update_columns(status: :void)
      elsif Time.zone.now < voucher.expiry_date && voucher.void?
        voucher.update_columns(status: :effective)
      end
    end
  end

  def auto_clear_cart
    HardWorker.perform_at(Time.now)
  end
end
