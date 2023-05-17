require "faraday"

require_relative "aleph-alpha/version"
require_relative "aleph-alpha/http"
require_relative "aleph-alpha/client"
require_relative "aleph-alpha/tokens"
require_relative "aleph-alpha/models"
require_relative "aleph-alpha/users"

module AlephAlpha
  class Error < StandardError; end
  class ConfigurationError < Error; end

  class Configuration
    attr_writer :access_token
    attr_accessor :uri_base, :request_timeout

    DEFAULT_URI_BASE = "https://api.aleph-alpha.com".freeze
    DEFAULT_REQUEST_TIMEOUT = 120

    def initialize
      @access_token = nil
      @uri_base = DEFAULT_URI_BASE
      @request_timeout = DEFAULT_REQUEST_TIMEOUT
    end

    def access_token
      return @access_token if @access_token

      error_text = "AlephAlpha access token missing!"
      raise ConfigurationError, error_text
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= AlephAlpha::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
