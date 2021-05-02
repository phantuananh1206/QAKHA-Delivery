class Api::V1::PartnersController < Api::V1::ApplicationController
  def index
    @partners = fetch_partners_from_redis
    render json: @partners, status: :ok
  end

  def show_partner
    @partner = Partner.find_by(id: params[:id])
    if @partner.present?
      render json: { partner: @partner.as_json(except: [:password], include: [:categories => { :include => :products }]),
                     avg_point: @partner.avg_point_feedback_partner,
                     number_of_reviews: @partner.number_of_reviews }, status: :ok
    else
      render json: { message: 'Partners not found' }, status: :not_found
    end
  end

  private

  def fetch_partners_from_redis
    begin
      partners = $redis.get 'partners'

      if partners.nil?
        partners = Partner.includes(categories: [:products]).to_json(except: [:password], include: [:categories => { :include => :products }])
        $redis.set('partners', partners)
      end
      partners = JSON.load partners
    rescue => error
      puts error.inspect
      partners = Partner.includes(categories: [:products]).as_json(except: [:password], include: [:categories => { :include => :products }])
    end
    partners
  end
end
