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
      attribute :result,       String
      attribute :step,         String

      def artifacts_url
        artifactsUrl
      end

      def log_url
        logUrl
      end

      def created_at
        createdAt
      end

      def started_at
        startedAt
      end

      def finished_at
        finishedAt
      end
    end
  end
end
