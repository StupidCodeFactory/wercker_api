module WerckerAPI
  class PipelineRunner

    class Timeout < RuntimeError
      def initialize(pipeline_id, pipeline_runner)
        msg = <<-EOM
Pipeline #{pipeline_id} did not finish in a timely fashion.

#{pipeline_runner.max_attempts} attempts were made with a #{pipeline_runner.delay} seconds delay between each attempts.

You  either can try to:
    - Increase the max attempts count.
      Beware of the API rate limit, specially
      if you have many applications and pipelines
      under the same account.
    - the delay between each attempts
    - or both

Good Luck!
EOM
        super(msg)
      end
    end

    attr_accessor :delay, :max_attempts

    def initialize(client, max_attempts: 20, delay: 10)
      self.client          = client
      self.max_attempts     = max_attempts
      self.delay           = delay
      self.current_attempt = 0
    end

    def run(pipeline_id, trigger_run_params = {})
      run = client.trigger_run pipeline_id, trigger_run_params

      while %w[running notstarted].include?(run.status)
        raise Timeout.new(pipeline_id, self) if max_attempt_reached?
        sleep @delay
        run = client.run(run.id)
        @current_attempt += 1
      end

      run
    end

    private

    attr_accessor :client, :current_attempt
    def max_attempt_reached?
      current_attempt >= max_attempts
    end
  end
end
