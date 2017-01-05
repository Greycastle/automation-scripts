require_relative '../execution_error.rb'

module Loopia
  # Defines the loopia landing page
  class LandingPage
    def initialize(driver)
      @driver = driver
    end

    def login_button
      @driver.find_element(:id, 'login-btn-cz')
    end

    def username_input
      @driver.find_element(:id, 'username')
    end

    def password_input
      @driver.find_element(:id, 'password')
    end

    def submit_login_button
      @driver.find_element(:css, "input[value='Logga in']")
    end

    def validate_no_login_error
      error_box_matches = @driver.find_elements(:css, '.error-box')
      error = error_box_matches.select(&:displayed?).first
      raise ExecutionError, error.text unless error.nil?
    end

    def login(username, password)
      login_button.click
      wait = Selenium::WebDriver::Wait.new(timeout: 2)
      wait.until { username_input.displayed? }
      username_input.send_keys(username)
      password_input.send_keys(password)
      submit_login_button.click
      validate_no_login_error
    end
  end
end
