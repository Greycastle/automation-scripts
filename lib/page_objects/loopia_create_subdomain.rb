require_relative '../execution_error.rb'

module Loopia
  # Defines the loopia landing page
  class CreateSubdomainPage
    def initialize(driver)
      @driver = driver
    end

    def topdomain_list
      @driver.find_element(:id, 'loopia_add_subdomain_add_domain')
    end

    def subdomain_input
      @driver.find_element(:id, 'loopia_add_subdomain_add_subdomains')
    end

    def add_button
      @driver.find_element(:css, "input[value='Lägg till']")
    end

    def create_subdomain(domain_name)
      wait = Selenium::WebDriver::Wait.new(timeout: 5)
      wait.until { topdomain_list.displayed? }
      topdomain = domain_name.split('.').last(2).join('.')
      domain_name = domain_name.slice(0, domain_name.size - topdomain.size - 1)
      topdomain_list.click
      topdomains = topdomain_list.find_elements(:tag_name, 'option')
      topdomain_item = topdomains.find { |e| e.text == topdomain }
      if topdomain_item.nil?
        raise ExecutionError, "Invalid topdomain: #{topdomain}"
      end
      topdomain_item.click
      subdomain_input.send_keys domain_name
      add_button.click
    end
  end
end
