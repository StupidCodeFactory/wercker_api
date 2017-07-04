require 'spec_helper'

RSpec.describe WerckerAPI::PipelineRunner do
  let(:client)      { WerckerAPI::Client.new }
  let(:pipeline_id) { '595a6b1b24ac030100da5307' }
  let(:args)        { [client] }

  subject { described_class.new(*args) }

  describe '#run' do
    context 'when the run finishes' do
      it 'runs the pipeline and waited until finished', vcr: { cassette_name: :run_pipeline } do
        expect(subject.run(pipeline_id, branch: 'pipeline-runner').status).to eq('finished')
      end
    end

    context 'when the run times out', vcr: { cassette_name: :run_pipeline_with_timeout } do
      # need to finish within 2 attemtps with a 2 second delay between each
      #  so build will timeout after around 4 seconds
      let(:args) { [client, max_attempts: 2, delay: 2] }

      it 'raise an excpetion' do
        expect {
          subject.run(pipeline_id, branch: 'pipeline-runner')
        }.to raise_error(RuntimeError, <<-EOM)
Pipeline #{pipeline_id} did not finish in a timely fashion.

2 attempts were made with a 2 seconds delay between each attempts.

You  either can try to:
    - Increase the max attempts count.
      Beware of the API rate limit, specially
      if you have many applications and pipelines
      under the same account.
    - the delay between each attempts
    - or both

Good Luck!
EOM
      end
    end
  end

end
