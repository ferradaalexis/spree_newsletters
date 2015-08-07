module Spree
  class NewslettersController < Spree::BaseController
    def create
      # subscriber = SpreeNewsletters::MailchimpSubscriber.new

      # result = subscriber.subscribe(email: newsletter_params[:email])

      # if result[:success]
        flash[:notice] = Spree.t(:suscribed, scope: :newsletter)
      # else
      #   flash[:error] = result[:error]
      # end

      redirect_to request.referer
    end

    private
      def newsletter_params
        params.require(:newsletter).allow(:email)
      end
  end
end
