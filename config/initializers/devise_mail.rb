ActionMailer::Base.smtp_settings = {
 :address              => "SMTP SERVER ADDRESS",
 :port                 => 80,
 :domain               => "Domain Name",
 :authentication       => :plain,
 :user_name            => "USERNAME",
 :password             => "PASSWORD"

}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
