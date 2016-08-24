module Smoggy
  class Environment
    attr_accessor :config
    attr_accessor :token

    def initialize(path = ENV[Constants::SECRETS])
      @token = ENV['AIRNOW_API_KEY']
      load_secrets_from_yaml(path) unless token
      fetch_token unless token
      freeze
    end

    def load_secrets_from_yaml(path)
      raise 'Secrets file not found' unless File.exist?(path)
      @config = YAML.load_file(path)
      @config.deep_symbolize_keys!
    end

    def fetch_token
      return token if token
      raise 'Token not set as ENV variable' unless config[:token]
      @token = config[:token]
    end

    private :load_secrets_from_yaml, :fetch_token
  end
end
