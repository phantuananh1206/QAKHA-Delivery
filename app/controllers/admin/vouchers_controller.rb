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
      flash[:success] = 'Create voucher success'
      redirect_to admin_vouchers_path
    else
      flash.now[:danger] = 'Create voucher failed'
      render :new
    end
  end

  def update
    if @voucher.update(voucher_params)
      flash[:success] = 'Update voucher success'
      redirect_to admin_vouchers_path
    else
      flash.now[:danger] = 'Update voucher failed'
      render :edit
    end
  end

  def destroy
    if @voucher.destroy
      flash[:success] = 'Delete voucher success'
    else
      flash[:danger] = 'Delete voucher failed'
    end
    redirect_to admin_vouchers_path
  end

  def update_status
    update_status_voucher
  end

  def export
    @vouchers = Voucher.order(:code)
    respond_to do |format|
	    format.xls { send_data @vouchers.to_xls }
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

    flash[:danger] = 'Voucher not found'
    redirect_to admin_vouchers_path
  end

  def list_partners
    @partners = Partner.all
  end

  def update_status_voucher
    @voucher.send("#{params[:status]}!")
    flash[:success] = "Update status #{params[:status]} success"
  rescue StandardError
    flash[:danger] = "Update status failed"
  ensure
    redirect_to admin_vouchers_path
  end
end
