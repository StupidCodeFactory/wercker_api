require 'spec_helper'

RSpec.describe WerckerAPI::ApplicationdRunner do

  let(:client)           { WerckerAPI::Client.new }
  let(:application_name) { 'wercker_api' }
  let(:user_name)        { 'StupidCodeFactory' }
  subject { described_class.new(client, user_name) }

  describe '#run' do

    it 'starts a run', vcr: { cassette_name: :application_runner } do
      subject.run(application_name).status('finished')
    end
  end
end
