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
      raise Errors::SECRETS_NOT_FOUND_ERROR unless File.exist?(path)

      config_string = ERB.new(File.read(path))
      @config = SafeYAML.load(config_string.result)
      @config.deep_symbolize_keys!
    end

    def fetch_token
      raise 'Token not set as ENV variable' unless config[:token]
      token = config[:token]
      token
    end
  end
end
