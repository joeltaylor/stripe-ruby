# frozen_string_literal: true

require ::File.expand_path("../test_helper", __dir__)

module Stripe
  class PriceTest < Test::Unit::TestCase
    should "be listable" do
      prices = StripeClient.new.prices.list
      assert_requested :get, "#{Stripe.api_base}/v1/prices"
      assert prices.data.is_a?(Array)
      assert prices.data[0].is_a?(Stripe::Price)
    end

    should "be retrievable" do
      price = StripeClient.new.prices.retrieve("price_123")
      assert_requested :get, "#{Stripe.api_base}/v1/prices/price_123"
      assert price.is_a?(Stripe::Price)
    end

    should "be creatable" do
      price = StripeClient.new.prices.create(
        unit_amount: 5000,
        currency: "usd",
        recurring: {
          interval: "month",
        },
        product_data: {
          name: "Product name",
        }
      )
      assert_requested :post, "#{Stripe.api_base}/v1/prices"
      assert price.is_a?(Stripe::Price)
    end

    should "be saveable" do
      price = StripeClient.new.prices.retrieve("price_123")
      price.metadata["key"] = "value"
      price.save
      assert_requested :post, "#{Stripe.api_base}/v1/prices/#{price.id}"
    end

    should "be updateable" do
      price = StripeClient.new.prices.update("price_123", metadata: { foo: "bar" })
      assert_requested :post, "#{Stripe.api_base}/v1/prices/price_123"
      assert price.is_a?(Stripe::Price)
    end
  end
end
