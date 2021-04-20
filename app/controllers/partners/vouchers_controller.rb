class Partners::VouchersController < ApplicationController
  layout "layouts/partner"
  before_action :check_sign_in
  before_action :load_voucher, only: %i(show update edit destroy)

  def index
    # @vouchers = current_partner.vouchers.all.page(params[:page]).per(2)
    @search = current_partner.vouchers.search(params[:q])
    @vouchers = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @voucher = Voucher.new
  end

  def create
    @voucher = Voucher.new voucher_params.merge(partner_id: current_partner.id)
    # byebug
    if @voucher.save
      flash[:success] = "Creat new voucher successful"
      redirect_to partners_vouchers_path
    else
      flash.now[:danger] = "Creat new voucher fail"
      render :new
    end
  end

  def update
    if @voucher.update_attributes voucher_params
      flash[:success] = "Update voucher successful"
      redirect_to partners_vouchers_path
    else
      render :edit
    end
  end

  def destroy
    if @voucher.destroy
      flash[:success] = "Delete voucher successful"
    else
      flash[:danger] = "You cannot delete this voucher. If you delete it, it will affect the store's statistics."
    end
    redirect_to partners_vouchers_path
  end

  private

  def voucher_params
    params.require(:voucher).permit :code, :discount, :condition, :expiry_date, :usage_limit, :description
  end

  def load_voucher
    return if @voucher = current_partner.vouchers.find_by(id: params[:id])
    @voucher.update_status_voucher

    flash[:info] = "Voucher is empty"
    redirect_to partners_vouchers_path
  end
end
