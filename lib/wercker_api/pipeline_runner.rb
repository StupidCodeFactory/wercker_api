module WerckerAPI
  class PipelineRunner
    def initialize(client, max_attempt = 20, delay = 10)
      self.client          = client
      self.max_attempt     = max_attempt
      self.delay           = delay
      self.current_attempt = 0
    end

    def run(pipeline_id)
      run = client.trigger_run pipeline_id

      while %w[running notstarted].include?(run.status) && !max_attempt_reached?
        sleep delay
        run = client.run(run.id)
        @current_attempt += 1
      end
      run
    end

    private

    attr_accessor :client, :max_attempt, :delay, :current_attempt
    def max_attempt_reached?
      current_attempt >= max_attempt
    end
  end
end
