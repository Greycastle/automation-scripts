require 'selenium-webdriver'
require_relative 'lib/precondition_error.rb'
require_relative 'lib/execution_error.rb'
require_relative 'lib/hostname_arguments.rb'
require_relative 'lib/page_objects/loopia_landing.rb'
require_relative 'lib/page_objects/loopia_user_landing.rb'
require_relative 'lib/page_objects/loopia_create_subdomain.rb'

def launch_website(browser)
  driver = Selenium::WebDriver.for browser
  driver.navigate.to 'http://www.loopia.se'
  driver
rescue Selenium::WebDriver::Error::WebDriverError => e
  raise PreconditionError, e
end

def user_input(help_text)
  $stdout.write help_text
  $stdin.gets.chomp
end

def collect_login(arguments)
  username = ENV['LOOPIA_USERNAME'] || user_input('Enter loopia username: ')
  password = ENV['LOOPIA_PASSWORD'] || user_input('Enter loopia password: ')
  arguments[:username] = username
  arguments[:password] = password
end

def login(driver, args)
  landing_page = Loopia::LandingPage.new(driver)
  landing_page.login(args[:username], args[:password])
end

def create_subdomain(driver, domain_name)
  user_landing = Loopia::UserLandingPage.new(driver)
  user_landing.create_subdomain_link.click
  subdomain_page = Loopia::CreateSubdomainPage.new(driver)
  subdomain_page.create_subdomain(domain_name)
end

begin
  args = parse_commandline_options
  collect_login(args)
  driver = launch_website(args[:browser])
  login(driver, args)
  create_subdomain(driver, args[:hostname])
rescue PreconditionError, ExecutionError => e
  $stderr.puts e.message
  Kernel.exit 1
ensure
  # driver.quit unless driver.nil?
end
