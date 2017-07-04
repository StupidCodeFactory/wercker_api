module WerckerAPI
  class Settings
    include Virtus.model
    attribute :privacy,         String
    attribute :stack,           Integer
    attribute :ignoredBranches, Array[String]

    def ignored_branches
      ignoredBranches
    end
  end

  class Application
    INDEX = -> (version, username) { "/api/#{version}/applications/#{username}" }
    SHOW  = -> (version, username, application) { "/api/#{version}/applications/#{username}/#{application}" }

    include Virtus.model
    attribute :id,             String
    attribute :url,            String
    attribute :name,           String
    attribute :owner,          Owner
    attribute :builds,         String
    attribute :deploys,        String
    attribute :scm,            SCM
    attribute :badgeKey,       String
    attribute :createdAt,      Time
    attribute :updatedAt,      Time
    attribute :allowedActions, Array[String]
    attribute :theme,          String
    attribute :settings,       Settings
    attribute :privacy,        String
    attribute :stack,          Integer
    attribute :userId,         String

    def badge_key
      badgeKey
    end

    def created_at
      createdAt
    end

    def updated_at
      updatedAt
    end

    def allowed_actions
      allowedActions
    end

  end
end
