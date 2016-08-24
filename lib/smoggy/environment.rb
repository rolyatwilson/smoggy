module Smoggy
  class Environment
    attr_accessor :config
    attr_accessor :token

    def initialize(path = ENV[Constants::SECRETS])
      load_secrets_from_yaml(path)
      fetch_token
      freeze
    end

    def load_secrets_from_yaml(path)
      raise 'Secrets file not found' unless File.exist?(path)
      @config = YAML.load_file(path)
      @config.deep_symbolize_keys!
    end

    def fetch_token
      raise 'Token not set as ENV variable' unless config[:token]
      token = config[:token]
      token
    end
  end
end
