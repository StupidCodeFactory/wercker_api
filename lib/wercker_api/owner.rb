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

  class User < Owner; end
end
