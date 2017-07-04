require 'spec_helper'

RSpec.describe WerckerAPI::Application::Workflow, vcr: { cassette_name: :application_workflow } do
  let(:client)      { WerckerAPI::Client.new }

  let(:workflow_id) { '595aeee73c2e150001977cad' }

  subject { client.application_workflow(workflow_id) }

  let(:expected_attributes) do
    {
      url: 'https://app.wercker.com/api/v3/workflows/595aeee73c2e150001977cad',
      createdAt: Time.parse('2017-07-04T01:27:03.044Z'),
      updatedAt: Time.parse('2017-07-04T01:28:31.447Z'),
      id: '595aeee73c2e150001977cad',
      startedAt: Time.parse('2017-07-04T01:27:16.486Z'),
      trigger: 'git',
      startedAt: Time.parse('2017-07-04T01:27:16.486Z')
    }
  end
  it { is_expected.to have_attributes(expected_attributes) }

  describe 'complexe attributes' do
    describe '#user' do
      specify do
        expect(subject.user).to have_attributes(
          'user_id' => '56a4de11212b43b24e0b6175',
          'name' => 'yann',
          'type' => 'wercker'
        )
      end

      describe '#meta' do
        specify do
          expect(subject.user.meta).to have_attributes('username' => 'stupidcodefactory')
        end
      end

      describe '#avatar' do
        specify do
          expect(subject.user.avatar).to have_attributes('gravatar' => 'a4346267407e112504b5dab1dac534ea')
        end
      end
    end
    describe '#application' do
      specify do
        expect(subject.application).to have_attributes(
          id:        '595a6b1ba01812010072fc1c',
          url:       'https://app.wercker.com/api/v3/applications/stupidcodefactory/wercker_api',
          name:      'wercker_api',
          createdAt: Time.parse('2017-07-03T16:04:43.374Z'),
          updatedAt: Time.parse('2017-07-03T20:29:42.731Z'),
          privacy:  'public',
          stack:    6,
          theme:    'Amethyst'
        )
      end

      describe '#owner' do
        specify do
          expect(subject.application.owner).to have_attributes(type: 'wercker', name: 'yann', userId: '56a4de11212b43b24e0b6175')
        end

        describe '#avatar' do
          specify do
            expect(subject.application.owner.avatar).to have_attributes(gravatar: 'a4346267407e112504b5dab1dac534ea')
          end
        end

        describe '#meta' do
          specify do
            expect(subject.application.owner.meta).to have_attributes(username: 'StupidCodeFactory', type: 'user', werckerEmployee: false)
          end
        end
      end
    end

    describe '#data' do
      specify do
        expect(subject.data).to have_attributes(
          branch: 'master',
          commitHash: 'a49e01b9a11f6941d79d4a4bce4214ef90193d02',
          message: "Merge branch 'code-coverage'"
        )
      end

      describe '#scm' do
        specify do
          expect(subject.data.scm).to have_attributes(
            type:       'git',
            owner:      'StupidCodeFactory',
            domain:     'github.com',
            repository: 'wercker_api'
          )
        end
      end
    end

    describe '#items' do
      specify do
        expect(subject.items.first).to have_attributes(
          'id' => '595aeee73c2e150001977cae',
          'progress' => 100,
          'result' => 'passed',
          'status' => 'finished',
          'type' => 'run',
          'updatedAt' => Time.parse('2017-07-04T01:27:30.640Z')
        )
      end

      describe '#data' do
        specify do
          expect(subject.items.first.data).to have_attributes(
            'targetName' => 'build',
            'pipelineId' => '595a6b1b24ac030100da5307',
            'restricted' => false,
            'totalSteps' => 8,
            'stepName'   => 'store',
            'runId'      => '595aeee73c2e150001977cac'
          )
        end
      end
    end
  end
end
