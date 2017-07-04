module WerckerAPI
  class ApplicationdRunner
    def initialize(client, user_name)
      self.client    = client
      self.user_name = user_name
    end

    def run(application_name)
      application = client.application(user_name, application_name)
      workflows   = client.application_workflows application.id

      workflows.each do |workflow|
        ap workflow
      end
    end

    private

    attr_accessor :client, :user_name
  end
end
