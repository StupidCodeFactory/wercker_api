require 'spec_helper'

RSpec.describe WerckerAPI::Run, vcr: { cassette_name: :run }  do
  let(:client) { WerckerAPI::Client.new  }

  subject { client.run('595aef023c2e150001977cc3') }

  let(:expected_attributes) do
    {
      "id" => "595aef023c2e150001977cc3",
      "url" => "https://app.wercker.com/api/v3/runs/595aef023c2e150001977cc3",
      "branch" => "master",
      "commitHash" => "a49e01b9a11f6941d79d4a4bce4214ef90193d02",
      "createdAt" => Time.parse("2017-07-04T01:27:30.634Z"),
      "envVars" => [],
      "finishedAt" => Time.parse("2017-07-04T01:28:19.345Z"),
      "message" => "Auto trigger from Pipeline \"build\" to Pipeline \"deploy\"",
      "progress" => 100,
      "result" => "passed",
      "startedAt" => Time.parse("2017-07-04T01:27:30.666Z"),
      "status" => "finished",
      "pullRequest" => {  }
    }
  end

  it { is_expected.to have_attributes(expected_attributes) }

  describe 'complexe attributes' do
    describe '#pipeline' do
      specify do
        expect(subject.pipeline).to have_attributes(
                                      "id"=>"595aeb089a634a010023715e",
                                      "url"=>"https://app.wercker.com/api/v3/pipelines/595aeb089a634a010023715e",
                                      "createdAt"=> Time.parse("2017-07-04T01:10:32.728Z"),
                                      "name"=>"deploy",
                                      "permissions"=>"read",
                                      "pipelineName"=>"deploy",
                                      "setScmProviderStatus"=>false,
                                      "type"=>"pipeline"
                                    )
      end

    end
    describe '#commits' do
      specify do
        expect(subject.commits.first).to have_attributes(
                                           "_id" => "595aeee73c2e150001977cb0",
                                           "commit" => "c5912ba0343b0547b46bed3988d47746263046bd",
                                           "message" => "bump",
                                           "by" => "yann marquet"
                                         )
      end
    end

    describe '#sourceRun' do
      specify do
        expect(subject.source_run).to have_attributes(
                                        "id" => "595aeee73c2e150001977cac",
                                        "url" => "https://app.wercker.com/api/v3/runs/595aeee73c2e150001977cac",
                                        "branch" => "master",
                                        "commitHash" => "a49e01b9a11f6941d79d4a4bce4214ef90193d02",
                                        "createdAt" => Time.parse("2017-07-04T01:27:03.125Z"),
                                        "finishedAt" => Time.parse("2017-07-04T01:27:23.507Z"),
                                        "message" => "Merge branch 'code-coverage'",
                                        "progress" => 100,
                                        "result" => "passed",
                                        "startedAt" => Time.parse("2017-07-04T01:27:03.211Z"),
                                        "status" => "finished",
                                      )
      end
      describe '#pipeline' do
        specify do
          expect(subject.source_run.pipeline).to have_attributes(
                                                   "id"=>"595a6b1b24ac030100da5307",
                                                   "url"=> "https://app.wercker.com/api/v3/pipelines/595a6b1b24ac030100da5307",
                                                   "created_at"=> Time.parse("2017-07-03T16:04:43.730Z"),
                                                   "name"=>"build",
                                                   "permissions"=>"public",
                                                   "pipeline_name"=>"build",
                                                   "set_scm_provider_status"=>true,
                                                   "type"=>"git"
                                                 )
        end

      end
      describe '#user' do

        specify do
          expect(subject.source_run.user).to have_attributes(
                                               "userId"=>"56a4de11212b43b24e0b6175",
                                               "name"=>"yann",
                                               "type"=>"wercker"
                                             )
        end

        describe '#avatar' do
          specify do
            expect(subject.source_run.user.avatar).to have_attributes("gravatar"=>"a4346267407e112504b5dab1dac534ea")
          end
        end

        describe '#meta' do
          specify do
            expect(subject.source_run.user.meta).to have_attributes("username"=>"stupidcodefactory", "type"=>"")
          end
        end
      end
    end
  end
end
