class BraintreeWebhooksController < ApplicationController

  skip_filter :check_email_confirmation, :dashboard_only

  def challenge
    challenge_response = BraintreeService.webhook_notification_verify(@current_community, params[:bt_challenge])

    # TODO if fail/success?

    render :text => challenge_response, :status => 200
  end
end