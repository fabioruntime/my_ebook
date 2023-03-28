# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end

ActionMailer::Base.smtp_settings = {
  :address => 'smtp.gmail.com',
  :port => '587',
  :domain => 'runtime-revolution.com',
  :user_name => ENV['MAILER_USERNAME'],
  :password => ENV['MAILER_PASSWORD'],
  :authentication => :plain,
  :enable_starttls_auto => true
}
