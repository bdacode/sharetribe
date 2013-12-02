require 'spec_helper'

describe BraintreeWebhooksController do
  describe "#create" do

    it "returns 200 for challenge" do
      community = FactoryGirl.create(:community, :domain => "market.custom.org")
      request.host = "market.custom.org"

      get :challenge

      response.status.should == 200

      # The response format seems to be 16 random chars, pipe '|' and 40 random chars
      first_part, last_part = response.body.split("|")
      first_part.length.should be_equal 16
      last_part.length.should be_equal 40
    end
  end
end
