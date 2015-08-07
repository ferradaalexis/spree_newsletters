require 'mailchimp'

module SpreeNewsletters
  class MailchimpSubscriber
    def initialize
      @logger = Logger.new(Rails.root.join('log/newsletter_subscription.log'))
    end

    def subscribe(email:)
      @logger.debug("#subscribe!(#{@email})")
      { success: true }
    end
  end
end
