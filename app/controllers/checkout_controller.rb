class CheckoutController < ApplicationController
  def create
    @cart = session[:cart]
    @cart_items = []

    province = current_user.province
    gst = province.gst
    pst = province.pst
    hst = province.hst
    total_tax_rate = gst + pst + hst

    @cart.each do |product_id, quantity|
      product = Product.find(product_id)

      base_price = product.price_cents
      tax_amount = (base_price * total_tax_rate).round

      @cart_items << {
        id: product.id.to_s,
        title: product.title,
        quantity: quantity,
        description: product.description,
        image: product.image,
        base_price: base_price,
        tax_amount: tax_amount,
        total_price: base_price + tax_amount
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
          unit_amount: item[:total_price]
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
