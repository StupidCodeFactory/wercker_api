module WerckerAPI
  class Meta
    include Virtus.model
    attribute :username,        String
    attribute :type,            String
    attribute :werckerEmployee, Boolean

    def wercker_employee
      werckerEmployee
    end
  end

  class Avatar
    include Virtus.model
    attribute :gravatar, String

  end
  class Owner
    include Virtus.model
    attribute :type,   String
    attribute :userId, String
    attribute :name,   String
    attribute :avatar, Avatar
    attribute :meta,   Meta

    def user_id
      userId
    end
  end

  class SCM
    include Virtus.model
    attribute :type,       String
    attribute :owner,      String
    attribute :domain,     String
    attribute :repository, String
  end

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
