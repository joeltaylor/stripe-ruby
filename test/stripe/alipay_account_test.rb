# frozen_string_literal: true

require ::File.expand_path("../test_helper", __dir__)

module Stripe
  class AlipayAccountTest < Test::Unit::TestCase
    context "#resource_url" do
      should "return a resource URL" do
        alipay_account = StripeClient.new.alipay_accounts.construct_from(
          id: "aliacc_123",
          customer: "cus_123"
        )
        assert_equal "/v1/customers/cus_123/sources/aliacc_123",
                     alipay_account.resource_url
      end

      should "raise without a customer" do
        alipay_account = StripeClient.new.alipay_accounts.construct_from(id: "aliacc_123")
        assert_raises NotImplementedError do
          alipay_account.resource_url
        end
      end
    end

    should "raise on #retrieve" do
      assert_raises NotImplementedError do
        StripeClient.new.alipay_accounts.retrieve("aliacc_123")
      end
    end

    should "raise on #update" do
      assert_raises NotImplementedError do
        StripeClient.new.alipay_accounts.update("aliacc_123", {})
      end
    end
  end
end
