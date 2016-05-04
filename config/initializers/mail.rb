if true || Rails.env == "production"
  ActionMailer::Base.smtp_settings = {
      address: 'smtp.sendgrid.net',
      port: '587',
      authentication: :plain,
      user_name: 'fool_ticketing',
      password: '6V7E9H628UbfrR',
      domain: 'thefool.it'
  }
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.default content_type: "text/plain"
else
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.default content_type: "text/plain"
end