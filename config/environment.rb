# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SampleRailsApp::Application.initialize!

ActionMailer::Base.default_url_options[:host] = 'secret-dawn-1486.herokuapp.com'
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = 
{ 
:address              => "smtp.gmail.com",
:port                 => 587,
:domain               => "gmail.com",
:user_name            => "manish@idifysolutions.com" ,
:password             => "immanish",
:authentication       => "plain",
:enable_starttls_auto => true
}