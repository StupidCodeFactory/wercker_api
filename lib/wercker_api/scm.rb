module WerckerAPI
  class SCM
    include Virtus.model
    attribute :type,       String
    attribute :owner,      String
    attribute :domain,     String
    attribute :repository, String
  end
end
