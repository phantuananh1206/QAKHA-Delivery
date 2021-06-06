class HardWorker
  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform
    @carts = Cart.all
    @carts.each do |cart|
      if cart.created_at < 7.days.ago
        cart.destroy
      end
    end
  end
end
