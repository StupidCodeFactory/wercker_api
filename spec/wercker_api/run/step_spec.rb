require 'spec_helper'

RSpec.describe WerckerAPI::Run::Step, vcr: { cassette_name: :run_steps } do
  let(:client) { WerckerAPI::Client.new }
  let(:run_id) { '595aef023c2e150001977cc3' }

  subject { client.run_steps(run_id) }

  let(:expected_attributes) do
    {
      "id" => "595aef023c2e150001977cc4",
      "url" => "https://app.wercker.com/api/v3/runsteps/595aef023c2e150001977cc4",
      "artifacts_url" => nil,
      "createdAt" => Time.parse("2017-07-04T01:27:30.635Z"),
      "finishedAt" => "2017-07-04T01:27:32.631Z",
      "logUrl" => "https://app.wercker.com/api/v3/runsteps/595aef023c2e150001977cc4/log",
      "order" => 1,
      "result" => "passed",
      "startedAt" => "2017-07-04T01:27:32.357Z",
      "status" => "finished",
      "step" => "get code"
    }
  end

  it { is_expected.to all(have_attributes(expected_attributes)) }
end
