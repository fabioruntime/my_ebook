class CheckoutController < ApplicationController

  def new
  end

  def create
    return if current_user.nil?
    ebook = Ebook.find(params[:ebook_id])
    redirect_to ebooks_path if ebook.nil?

    UserMailer.with(user: current_user, ebook: ebook).confirmation_email.deliver_later

    current_user.ebooks << ebook
    redirect_to current_user, notice:"The '#{ebook.title}' has been added to your library. An email has been sent to you."
  end

  def success
  end

  def cancel
  end
end
