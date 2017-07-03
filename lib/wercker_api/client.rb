require 'net/http'
require 'json'
module WerckerAPI

  class WerckerAPI::Error < ArgumentError
    def initialize(response)
      json = JSON.parse(response.body)
      msg = <<-EOM
Error: #{json['error']}, status: #{json['statusCode']}, message: #{json['message']}
EOM
      super(msg)
    end
  end

  class Client

    API_ENDPOINT = URI('https://app.wercker.com').freeze

    def initialize(token)
      self.api_token = token || ENV['WERCKER_API_TOKEN']
      raise_token_nil_error if api_token.nil?
    end

    def applications(user_name, params = {})
      get build_get_request(Application::INDEX['v3', user_name], params), ApplicationCollection
    end

    private
    attr_accessor :api_token

    def http_client
      @http_client ||= build_http_client
    end

    def raise_token_nil_error
      msg = <<-EOM
A token is required to communicate with the API, please refer to the read me.

   client = WerckerAPI::Client.new('2039e0239840239u0239uf0293v2093urbv0293urbv')

More inforation at: http://devcenter.wercker.com/docs/api/getting-started/authentication
EOM
      raise ArgumentError.new(msg)
    end

    def build_get_request(uri, params = {}, call)
      uri = URI::HTTP.build(path: uri, query: URI.encode_www_form(params))
      authorise_request(Net::HTTP::Get.new(uri))
    end

    def authorise_request(request)
      request['Authorization'] = "Bearer #{api_token}"
      request
    end

    def build_http_client
      http_client = Net::HTTP.new(API_ENDPOINT.host, API_ENDPOINT.port)
      http_client.use_ssl = true
      http_client
    end

    def get(request, serializer)
      response = http_client.request(request)
      handle(response, serializer)
    end

    def handle(response, klass)
      case response
      when Net::HTTPSuccess
        klass.new(JSON.parse(response.body))
      else
        handle_error(response)
      end
    end

    def handle_error(response)
      raise WerckerAPI::Error.new(response)
    end
  end

end