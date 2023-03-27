class CheckoutController < ApplicationController

  def create
    ebook = Ebook.find(params[:id])
    redirect_to ebooks_path if ebook.nil?

    # Stripe API

    respond_to do |format|
      format.html
      format.js
    end
  end

  def success
  end

  def cancel
  end
end
