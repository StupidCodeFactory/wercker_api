module WerckerAPI
  class Application

    class Deploy
      INDEX = -> (version, user_name, application) { "/api/#{version}/applications/#{user_name}/#{application}/deploys" }
    end

  end

end
