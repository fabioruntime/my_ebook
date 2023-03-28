class CheckoutController < ApplicationController

  def new
    byebug
    ebook = Ebook.find(params[:id])
    redirect_to ebooks_path if ebook.nil?

    UserMailer.with(user: current_user, ebook: ebook).confirmation_email.deliver_now

    current_user.ebooks << ebook
    redirect_to current_user, notice:"The '#{ebook.title}' has been added to your library. An email has been sent to you."
  end

  def create
  end

  def success
  end

  def cancel
  end
end
