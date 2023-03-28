module Api
  class MailchimpSubscriber

    def initialize
      @api_instance = MailchimpMarketing::Client.new()
      @api_instance.set_config({
        api_key: ENV['MAILCHIMP_API_KEY'],
        server: ENV['MAILCHIMP_API_SERVER']
      })
    end

    def create_subscriber(email)
      begin
        response =
        @api_instance.lists.set_list_member(
          ENV['MAILCHIMP_NEWSLETTER_ID'],
          subscriber_hash(email),
          {
            'email_address' => email,
            'status_if_new' => 'subscribed'
          }
        )
      p response
      rescue MailchimpMarketing::ApiError => e
        raise SubscribeNewsletterError
      end
    end

    def subscriber_hash(email)
      Digest::MD5.hexdigest(email.downcase)
    end
  end
end