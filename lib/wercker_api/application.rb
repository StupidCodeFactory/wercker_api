module WerckerAPI
  class Application
    INDEX = -> (version, username) { "/api/#{version}/applications/#{username}" }
  end
end
