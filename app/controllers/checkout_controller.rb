class CheckoutController < ApplicationController
  def create
    @cart = session[:cart]
    @cart_items = []
    @cart.each do |product_id, quantity|
      product = Product.find(product_id)
      @cart_items << {
        id: product.id.to_s,
        title: product.title,
        quantity: quantity,
        description: product.description,
        image: product.image,
        price: product.price_cents
      }
    end

    line_items = @cart_items.map do |item|
      {
        price_data: {
          currency: "cad",
          product_data: {
            name: item[:title],
            description: item[:description]
          },
          unit_amount: item[:price]
        },
        quantity: item[:quantity]
      }
    end

      session = Stripe::Checkout::Session.create(
        payment_method_types: [ "card" ],
        success_url: checkout_success_url,
        cancel_url: checkout_cancel_url,
        mode: "payment",
        line_items: line_items
      )

      redirect_to session.url, allow_other_host: true
  end

  def success
  end

  def cancel
  end
end
