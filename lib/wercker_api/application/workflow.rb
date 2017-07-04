module WerckerAPI
  class Application
    class Data
      include Virtus.model
      attribute :branch,     String
      attribute :commitHash, String
      attribute :message,    String
      attribute :scm,        SCM

      def commit_hash
        commitHash
      end
    end
    class PipelineItem
      include Virtus.model

      attribute :targetName,  String
      attribute :pipelineId,  String
      attribute :restricted,  Boolean
      attribute :totalSteps,  Integer
      attribute :currentStep, Integer
      attribute :stepName,    String
      attribute :runId,       String

      def step_name
        stepName
      end

      def run_id
        runId
      end

      def pipeline_id
        pipelineId
      end

      def total_steps
        totalSteps
      end

      def current_step
        currentStep
      end
    end

    class Item
      include Virtus.model

      attribute :data,      PipelineItem
      attribute :id,        String
      attribute :progress,  Integer
      attribute :result,    String
      attribute :status,    String
      attribute :type,      String
      attribute :updatedAt, Time

      def updated_at
        updatedAt
      end
    end

    class Workflow
      INDEX = -> (version) { "/api/#{version}/workflows" }
      SHOW = -> (version, workflow_id) { "/api/#{version}/workflows/#{workflow_id}" }

      include Virtus.model

      attribute :id,          String
      attribute :url,         String
      attribute :theme,       String
      attribute :trigger,     String
      attribute :application, Application
      attribute :createdAt,   Time
      attribute :updatedAt,   Time
      attribute :startedAt,   Time
      attribute :privacy,     Boolean
      attribute :stack,       Integer
      attribute :data,        Data
      attribute :items,       Array[Item]
      attribute :user,        User
    end
  end
end
