# frozen_string_literal: true

require ::File.expand_path("../test_helper", __dir__)

module Stripe
  class RefundTest < Test::Unit::TestCase
    should "be listable" do
      refunds = StripeClient.new.refunds.list
      assert_requested :get, "#{Stripe.api_base}/v1/refunds"
      assert refunds.data.is_a?(Array)
      assert refunds.first.is_a?(Stripe::Refund)
    end

    should "be retrievable" do
      refund = StripeClient.new.refunds.retrieve("re_123")
      assert_requested :get, "#{Stripe.api_base}/v1/refunds/re_123"
      assert refund.is_a?(Stripe::Refund)
    end

    should "be creatable" do
      refund = StripeClient.new.refunds.create(charge: "ch_123")
      assert_requested :post, "#{Stripe.api_base}/v1/refunds"
      assert refund.is_a?(Stripe::Refund)
    end

    should "be saveable" do
      refund = StripeClient.new.refunds.retrieve("re_123")
      refund.metadata["key"] = "value"
      refund.save
      assert_requested :post, "#{Stripe.api_base}/v1/refunds/#{refund.id}"
    end

    should "be updateable" do
      refund = StripeClient.new.refunds.update("re_123", metadata: { key: "value" })
      assert_requested :post, "#{Stripe.api_base}/v1/refunds/re_123"
      assert refund.is_a?(Stripe::Refund)
    end
  end
end
