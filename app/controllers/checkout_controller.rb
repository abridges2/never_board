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
    if session[:cart].blank?
      flash[:notice] = "Your order could not be completed. Please try again."
      return redirect_to products_path
    else
      cart = session[:cart]
      user = current_user
      province = user.province
      gst_rate = province.gst || 0
      pst_rate = province.pst || 0
      hst_rate = province.hst || 0
      tax_rate = gst_rate + pst_rate + hst_rate

      subtotal_cents = 0
      gst_cents = 0
      pst_cents = 0
      hst_cents = 0

      # Create the order
      order = Order.create!(
        user: user,
        province: province,
        address: user.address,
        gst_cents: 0,
        pst_cents: 0,
        hst_cents: 0,
        subtotal_cents: 0,
        total_cents: 0
      )

      # Create monetary values for the order
      cart.each do |product_id, quantity|
        product = Product.find(product_id)
        base_price = product.price_cents

        # Subtotal of order without tax
        cart_item_subtotal = base_price * quantity
        subtotal_cents += cart_item_subtotal

        # Individual item tax calculations
        gst_cents += (cart_item_subtotal * gst_rate).round
        pst_cents += (cart_item_subtotal * pst_rate).round
        hst_cents += (cart_item_subtotal * hst_rate).round

        # Create the order item
        OrderItem.create!(
          order: order,
          product: product,
          quantity: quantity,
          price_cents: base_price,
          total_cents: (cart_item_subtotal * (1 + tax_rate)).round
        )
      end

      total_cents = subtotal_cents + gst_cents + pst_cents + hst_cents

      # Update the order with the calculated values
      order.update!(
        subtotal_cents: subtotal_cents,
        gst_cents: gst_cents,
        pst_cents: pst_cents,
        hst_cents: hst_cents,
        total_cents: total_cents
      )
    end

    session[:cart] = nil
    flash[:notice] = "Your order has been completed & saved successfully."
    redirect_to checkout_thank_you_path
  end

  def cancel
    flash[:alert] = "Your checkout has been cancelled."
    redirect_to cart_index_path
  end

  def thank_you
    render "thank_you"
  end
end
