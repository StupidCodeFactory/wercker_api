module WerckerAPI
  class Application
    INDEX = -> (version, username) { "/api/#{version}/applications/#{username}" }
    include Virtus.model
  end
end
