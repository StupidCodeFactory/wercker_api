module WerckerAPI
  class Client
    def initialize(token)
      raise ArgumentError.new(<<-EOM)
A token is required to communicate with the API, please refer to the read me.

   client = WerckerAPI::Client.new('2039e0239840239u0239uf0293v2093urbv0293urbv')

More inforation at: http://devcenter.wercker.com/docs/api/getting-started/authentication
EOM
      self.token = token
    end

    private
    attr_accessor :token
  end

end
