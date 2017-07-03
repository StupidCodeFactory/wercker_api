module WerckerAPI
  class Application
    class Build
      INDEX =  -> (version, user_name, application) { "/api/#{version}/applications/#{user_name}/#{application}/builds" }

    end
  end
end
