module ApplicationHelper
  include Pagy::Frontend

  def gravatar_for(user, options = { size: 80})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
  end

  def number_to_currency_eur(number)
    number_to_currency(number, unit: "€", separator: ",", delimiter: "", format: "%n %u")
  end
end
