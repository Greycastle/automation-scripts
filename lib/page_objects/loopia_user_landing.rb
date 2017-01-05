require_relative '../execution_error.rb'

module Loopia
  # Defines the loopia landing page
  class UserLandingPage
    def initialize(driver)
      @driver = driver
    end

    def create_subdomain_link
      @driver.find_element(:link_text, 'Subdomän')
    end
  end
end
