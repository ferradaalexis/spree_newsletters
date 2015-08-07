require 'mailchimp'

module SpreeNewsletters
  class MailchimpSubscriber
    def initialize
      @logger    = Logger.new(Rails.root.join('log/newsletter_subscription.log'))
      @mailchimp = Mailchimp::API.new(api_key)
    rescue => error
      @logger.debug(error.message)
    end

    def subscribe(email:)
      @logger.debug("#subscribe!(#{email})")

      result = @mailchimp.lists.subscribe(list_id, {email: email})
      { success: true }

    rescue Mailchimp::ListAlreadySubscribedError => error
      @logger.debug(error.message)
      { success: false, error: Spree.t(:list_already_subscribed, email: email, scope: :newsletter) }

    rescue Mailchimp::ListDoesNotExistError => error
      @logger.debug(error.message)
      { success: false, error: Spree.t(:list_does_not_exist, scope: :newsletter) }

    rescue Mailchimp::ValidationError => error
      @logger.debug(error.message)
      { success: false, error: Spree.t(:invalid, scope: :newsletter) }

    rescue Mailchimp::Error => error
      if error.message
        @logger.debug(error.message)
        { success: false, error: error.message }
      else
        @logger.debug(e.message)
        { success: false, error: Spree.t(:unknow_error, scope: :newsletter) }
      end

    rescue => error
      @logger.debug(error.message)
      { success: false, error: error.message }
    end

    private
      def api_key
        Rails.application.secrets.mailchimp_api_key
      end

      def list_id
        Rails.application.secrets.mailchimp_list_id
      end
  end
end
