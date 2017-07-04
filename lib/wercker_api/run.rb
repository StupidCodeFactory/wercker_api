module WerckerAPI
  class Commit

    include Virtus.model

    attribute :_id,     String
    attribute :commit,  String
    attribute :message, String
    attribute :by,      String

  end

  class Run
    INDEX = -> (version) { "/api/#{version}/runs" }
    SHOW = -> (version, run_id) { "/api/#{version}/runs/#{run_id}" }

    include Virtus.model

    attribute :id, String
    attribute :url, String
    attribute :branch, String
    attribute :commitHash, String
    attribute :createdAt, Time
    attribute :envVars, Array[String]
    attribute :finishedAt, Time
    attribute :message, String
    attribute :progress, Integer
    attribute :result, String
    attribute :startedAt, Time
    attribute :status, String
    attribute :pullRequest, Hash
    attribute :commits, Array[Commit]
    attribute :sourceRun, Run
    attribute :user, User
    attribute :pipeline, Pipeline

    def source_run
      sourceRun
    end

    def commit_hash
      commitHash
    end

    def created_at
      createdAt
    end

    def finished_at
      finishedAt
    end

    def env_vars
      envVars
    end
  end
end
