module WerckerAPI
  class Run
    class Step

      include Virtus.model

      attribute :id,           String
      attribute :url,          String
      attribute :artifactsUrl, String
      attribute :logUrl,       String
      attribute :order,        Integer
      attribute :createdAt,    Time
      attribute :finishedAt,   Time
      attribute :startedAt,    Time
      attribute :status,       String
      attribute :step,         String
    end
  end
end
