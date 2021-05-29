class Api::V1::ContactsController < Api::V1::ApplicationController
  def contact
    if ContactMailer.contact(params[:email], params[:name], params[:content]).deliver_later
      ContactMailer.inform(params[:email], params[:name]).deliver_later
      render json: { message: 'Your request was submitted successfully'}, status: :ok
    end
  end
end
