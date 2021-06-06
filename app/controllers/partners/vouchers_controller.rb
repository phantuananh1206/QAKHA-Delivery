class Partners::VouchersController < Partners::PartnersController
  before_action :load_voucher, only: %i(show update edit destroy update_status)

  def index
    @search = current_partner.vouchers.search(params[:q])
    @vouchers = @search.result.includes(:orders).page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @voucher = Voucher.new
  end

  def create
    @voucher = Voucher.new voucher_params.merge(partner_id: current_partner.id)
    if @voucher.save
      flash[:success] = t('admin.voucher.create_success')
      redirect_to partners_vouchers_path
    else
      flash.now[:danger] = t('admin.voucher.create_failed')
      render :new
    end
  end

  def update
    if @voucher.update_attributes voucher_params
      flash[:success] = t('admin.voucher.update_success')
      redirect_to partners_vouchers_path
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
    redirect_to partners_vouchers_path
  end

  def update_status
    @voucher.send("#{params[:status]}!")
    flash[:success] = t('admin.voucher.update_status_success', status: "#{params[:status]}")
  rescue StandardError
    flash[:danger] = t('admin.voucher.update_status_failed')
  ensure
    redirect_to partners_vouchers_path
  end

  def export
    @vouchers = current_partner.vouchers.order(:code)
    if @vouchers.present?
      respond_to do |format|
        format.xls { send_data(@vouchers.to_xls, filename: filename_excel(t('admin.file_name.voucher'), Time.now)) }
      end
    else
      flash[:danger] = t('admin.voucher.empty')
      redirect_to partners_vouchers_path
    end
  end

  private

  def voucher_params
    params.require(:voucher).permit :code, :discount, :condition, :expiry_date, :usage_limit, :description
  end

  def load_voucher
    return if @voucher = current_partner.vouchers.find_by(id: params[:id])

    flash[:info] = t('admin.voucher.not_found')
    redirect_to partners_vouchers_path
  end
end
