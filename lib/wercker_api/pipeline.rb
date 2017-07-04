module WerckerAPI
  class Pipeline
    include Virtus.model
    attribute :id,                   String
    attribute :url,                  String
    attribute :createdAt,            Time
    attribute :name,                 String
    attribute :permissions,          String
    attribute :pipelineName,         String
    attribute :setScmProviderStatus, Boolean
    attribute :type,                 String

    def created_at
      createdAt
    end

    def pipeline_name
      pipelineName
    end

    def set_scm_provider_status
      setScmProviderStatus
    end
  end
end
