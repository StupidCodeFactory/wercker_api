require 'spec_helper'

RSpec.describe WerckerAPI::PipelineRunner do
  let(:client)  { WerckerAPI::Client.new }
  let(:pipeline_id) { '595a470724ac030100da3fe9' }

  subject { described_class.new(client) }

  it 'runs the pipeline and waited until finished', vcr: { cassette_name: :run_pipeline } do
    expect(subject.run(pipeline_id).status).to eq('finished')
  end
end
