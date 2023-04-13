class UserMailer < ApplicationMailer
  def confirmation_email
    @user = params[:user]
    @ebook = params[:ebook]
    @new_price = apply_discount(@ebook.price, 10)
    mail(to: @user.email, subject: "MYEBOOK - Order confirmation")
  rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
    puts "ERROR: #{e}"
  end

  def changestatus_email
    @user = params[:user]
    @ebook  = params[:ebook]
    mail(to: @user.email, subject: "MYEBOOK - Available now!")
  rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
    puts "ERROR: #{e}"
  end

  private

  def apply_discount(price, discount)
    price - (discount.to_f / 100 * price) unless price.blank?
    0
  end
end
