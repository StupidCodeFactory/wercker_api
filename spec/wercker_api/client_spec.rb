require 'spec_helper'

RSpec.describe WerckerAPI::Client do

  subject { described_class.new(token) }
  let(:token) { nil }

  describe '#initialize' do
    let(:token) { 'some_token' }
    context 'given an API token' do
      it { is_expected.to be_instance_of(described_class) }
    end

    context 'given a nil token' do
      let(:token) { nil }
      before do
        allow(ENV).to receive(:[]).with('WERCKER_API_TOKEN').and_return(nil)
      end
      it 'raises an ArgumentError' do
        expect {
          subject
        }.to raise_error(ArgumentError, <<-EOM)
A token is required to communicate with the API, please refer to the read me.

   client = WerckerAPI::Client.new('2039e0239840239u0239uf0293v2093urbv0293urbv')

More inforation at: http://devcenter.wercker.com/docs/api/getting-started/authentication
EOM
      end
    end
  end

  describe '#applications' do
    let(:user_name) { 'StupidCodeFactory' }

    it 'fetches applications', vcr: { cassette_name: :fetch_applications } do
      expect(subject.applications(user_name)).to all(be_instance_of(WerckerAPI::Application))
    end
  end

  describe '#application' do
    let(:user_name)   { 'StupidCodeFactory' }
    let(:application) { 'wercker_api' }

    it 'fetches an application', vcr: { cassette_name: :fetch_application } do
      expect(subject.application(user_name, application)).to be_instance_of(WerckerAPI::Application)
    end
  end
end
