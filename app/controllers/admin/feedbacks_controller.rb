class Admin::FeedbacksController < Admin::BaseController
  before_action :load_feedback, except: %i(index new create export)
  before_action :list_orders, :list_users, :list_drivers, :list_partners, except: %i(index destroy export)

  def index
    @search = Feedback.includes(:order, :user, :driver, :partner).search(params[:q])
    @feedbacks = @search.result.page(params[:page]).per(5)
    @search.build_condition
    @search.build_sort
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      flash[:success] = t('admin.feedback.create_success')
      redirect_to admin_feedbacks_path
    else
      flash.now[:danger] = t('admin.feedback.create_failed')
      render :new
    end
  end

  def update
    if @feedback.update(feedback_params)
      flash[:success] = t('admin.feedback.update_success')
      redirect_to admin_feedbacks_path
    else
      flash.now[:danger] = t('admin.feedback.update_failed')
      render :edit
    end
  end

  def destroy
    if @feedback.destroy
      flash[:success] = t('admin.feedback.delete_success')
    else
      flash[:danger] = t('admin.feedback.delete_failed')
    end
    redirect_to admin_feedbacks_path
  end

  def export
    @feedbacks = Feedback.all
    if @feedbacks.present?
      respond_to do |format|
        format.xls { send_data(@feedbacks.to_xls, filename: filename_excel(t('admin.file_name.feedback'), Time.now)) }
      end
    else
      flash[:danger] = t('admin.feedback.empty')
      redirect_to admin_feedbacks_path
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:content, :image, :point,
                                     :order_id, :user_id, :driver_id, :partner_id)
  end

  def load_feedback
    return if @feedback = Feedback.find_by(id: params[:id])

    flash[:danger] = t('admin.feedback.not_found')
    redirect_to admin_feedbacks_path
  end

  def list_orders
    @orders = Order.all
  end

  def list_users
    @users = User.all
  end

  def list_drivers
    @drivers = Driver.all
  end

  def list_partners
    @partners = Partner.all
  end
end
