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

    def initialize(token = nil, api_version = 'v3')
      self.api_token = token || ENV['WERCKER_API_TOKEN']
      raise_token_nil_error if api_token.nil?
      self.api_version = api_version
    end

    def applications(user_name, params = {})
      request build_get_request(Application::INDEX[api_version, user_name], params), ApplicationCollection
    end

    def application(user_name, application)
      request build_get_request(Application::SHOW[api_version, user_name, application]), Application
    end

    def update_application(user_name, application, branches)
      request build_put_request(Application::SHOW[api_version, user_name, application], { ignoredBranches: branches }), Application
    end

    def application_builds(user_name , application)
      request build_get_request(Application::Build::INDEX[api_version, user_name, application]), Application::BuildCollection
    end

    private
    attr_accessor :api_token, :api_version

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

    def build_get_request(uri, params = {})
      uri = URI::HTTP.build(path: uri, query: URI.encode_www_form(params))
      authorise_request(Net::HTTP::Get.new(uri))
    end

    def build_put_request(uri, params)
      request      = Net::HTTP::Patch.new(URI::HTTP.build(path: uri))
      request.body = JSON.dump(params)
      request['Content-Type'] = 'application/json'
      authorise_request(request)
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

    def request(request, serializer)
      handle(http_client.request(request), serializer)
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
