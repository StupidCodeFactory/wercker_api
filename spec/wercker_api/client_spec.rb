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
        expect do
          subject
        end.to raise_error(ArgumentError, <<-EOM)
A token is required to communicate with the API, please refer to the read me.

   client = WerckerAPI::Client.new('2039e0239840239u0239uf0293v2093urbv0293urbv')

More inforation at: http://devcenter.wercker.com/docs/api/getting-started/authentication
EOM
      end
    end
  end

  describe 'API' do
    let(:user_name)   { 'StupidCodeFactory' }
    let(:application) { 'wercker_api' }
    let(:pipeline_id) { '595a6b1b24ac030100da5307' }

    describe 'GET #applications' do
      it 'fetches applications', vcr: { cassette_name: :fetch_applications } do
        expect(subject.applications(user_name)).to all(be_instance_of(WerckerAPI::Application))
      end
    end

    describe 'GET #application' do
      it 'fetches an application', vcr: { cassette_name: :fetch_application } do
        expect(subject.application(user_name, application)).to be_instance_of(WerckerAPI::Application)
      end
    end

    describe 'PUT #application' do
      let(:branches) { ['a-dummy-branch'] }

      it 'updates the ignored branche', vcr: { cassette_name: :update_application } do
        expect do
          subject.update_application(user_name, application, branches)
        end.to change { subject.application(user_name, application).settings.ignored_branches }.from([]).to(['a-dummy-branch'])
      end
    end

    describe 'GET #application_buils' do
      it 'fetches application builds', vcr: { cassette_name: :application_builds } do
        expect(subject.application_builds(user_name, application)).to all(be_instance_of(WerckerAPI::Application::BuildCollection))
      end
    end

    describe 'GET #application_deploys' do
      it 'fetches application builds', vcr: { cassette_name: :application_deploys } do
        expect(subject.application_deploys(user_name, application)).to all(be_instance_of(WerckerAPI::Application::DeployCollection))
      end
    end

    describe '#application_workflows' do
      let(:application_id) { '595a6b1ba01812010072fc1c' }
      it 'fetches application workflows', vcr: { cassette_name: :application_workflows } do
        expect(subject.application_workflows(application_id)).to be_instance_of(WerckerAPI::Application::WorkflowCollection)
      end
    end

    describe '#application_workflow' do
      let(:workflow_id) { '595aeee73c2e150001977cad' }
      it 'fetches application workflows', vcr: { cassette_name: :application_workflow } do
        expect(subject.application_workflow(workflow_id)).to be_instance_of(WerckerAPI::Application::Workflow)
      end
    end

    describe '#runs' do
      describe 'with an application id' do
        let(:application_id) { '595a6b1ba01812010072fc1c' }

        it 'fetches an application runs', vcr: { cassette_name: :application_runs } do
          expect(subject.runs(application_id: application_id)).to be_instance_of(WerckerAPI::RunCollection)
        end
      end

      describe 'with an pipeline id' do
        it 'fetches a pipeline runs', vcr: { cassette_name: :pipeline_runs } do
          expect(subject.runs(pipeline_id: pipeline_id)).to be_instance_of(WerckerAPI::RunCollection)
        end
      end
    end

    describe '#run' do
      let(:run_id) { '595aef023c2e150001977cc3' }

      it 'fetches a run', vcr: { cassette_name: :run } do
        expect(subject.run(run_id)).to be_instance_of(WerckerAPI::Run)
      end
    end

    describe '#trigger_run' do
      it 'triggers a run', vcr: { cassette_name: :trigger_run } do
        expect(subject.trigger_run(pipeline_id)).to be_instance_of(WerckerAPI::Run)
      end
    end

    describe '#abort_run' do
      let(:run) { subject.trigger_run(pipeline_id) }
      it 'aborts a run', vcr: { cassette_name: :abort_run } do
        expect(subject.abort_run(run.id)).to be_instance_of(WerckerAPI::Run)
      end
    end
  end
end
