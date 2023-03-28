# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def confirmation_email
    # Set up a temporary order for the preview
    user = User.new(name: "Joe Smith", email: "joe@gmail.com", username: "joesmith", password: "123")
    ebook = Ebook.new(title: "Ebook Test", description: "test", date_release: "01-01-1999", price: '39.90', num_pages: 2)

    UserMailer.with(user: user, ebook: ebook).confirmation_email
  end
end
