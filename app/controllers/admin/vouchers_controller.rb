class Admin::VouchersController < Admin::BaseController
  before_action :load_voucher, except: %i(index new create export)
  before_action :list_partners, except: %i(index destroy export)

  def index
    @search = Voucher.includes(:partner).search(params[:q])
    @vouchers = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @voucher = Voucher.new
  end

  def create
    @voucher = Voucher.new(voucher_params)
    if @voucher.save
      flash[:success] = t('admin.voucher.create_success')
      redirect_to admin_vouchers_path
    else
      flash.now[:danger] = t('admin.voucher.create_failed')
      render :new
    end
  end

  def update
    if @voucher.update(voucher_params)
      flash[:success] = t('admin.voucher.update_success')
      redirect_to admin_vouchers_path
    else
      flash.now[:danger] = t('admin.voucher.update_failed')
      render :edit
    end
  end

  def destroy
    if @voucher.destroy
      flash[:success] = t('admin.voucher.delete_success')
    else
      flash[:danger] = t('admin.voucher.delete_failed')
    end
    redirect_to admin_vouchers_path
  end

  def update_status
    update_status_voucher
  end

  def export
    @vouchers = Voucher.order(:code)
    if @vouchers.present?
      respond_to do |format|
        format.xls { send_data @vouchers.to_xls }
      end
    else
      flash[:danger] = t('admin.voucher.empty')
      redirect_to admin_vouchers_path
    end
  end

  private

  def voucher_params
    params.require(:voucher).permit(:code, :discount, :condition,
                                    :expiry_date, :usage_limit,
                                    :description, :partner_id)
  end

  def load_voucher
    return if @voucher = Voucher.find_by(id: params[:id])

    flash[:danger] = t('admin.voucher.not_found')
    redirect_to admin_vouchers_path
  end

  def list_partners
    @partners = Partner.all
  end

  def update_status_voucher
    @voucher.send("#{params[:status]}!")
    flash[:success] = t('admin.voucher.update_status_success', status: "#{params[:status]}")
  rescue StandardError
    flash[:danger] = t('admin.voucher.update_status_failed')
  ensure
    redirect_to admin_vouchers_path
  end
end
