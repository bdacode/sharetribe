#
# This class makes Braintree calls thread-safe even though we're using
# different configurations per Braintree call
#
class BraintreeService

  class << self

    @@mutex = Mutex.new

    # Give `community` and set Braintree configurations
    def configure_for(community)
      Braintree::Configuration.environment = :sandbox
      Braintree::Configuration.merchant_id = "vyhwdzxmbvw64z8v"
      Braintree::Configuration.public_key = "fp654nr3qzzz5k78"
      Braintree::Configuration.private_key = "119c7481abe69f6e4c1ca1d3d8ad17e3"
    end

    # Reset Braintree configurations
    def reset_configurations()
      # TODO
    end

    def do_stuff(community)
      
      mutex.synchronize {
        configure_for(community)

        # Now do stuff

        reset_configurations()
      }

    end

    def webhook_notification_verify(community, challenge)

      @@mutex.synchronize {
        configure_for(community)

        challenge_response = Braintree::WebhookNotification.verify(challenge)

        reset_configurations()

        challenge_response
      }
    end
  end
end