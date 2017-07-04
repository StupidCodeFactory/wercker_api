require 'spec_helper'

RSpec.describe WerckerAPI::PipelineRunner do
  let(:client) { WerckerAPI::Client.new }
  let(:pipeline_id) { '595a6b1b24ac030100da5307' }

  subject { described_class.new(client) }

  it 'runs the pipeline and waited until finished', vcr: { cassette_name: :run_pipeline } do
    expect(subject.run(pipeline_id, branch: 'pipeline-runner').status).to eq('finished')
  end
end
