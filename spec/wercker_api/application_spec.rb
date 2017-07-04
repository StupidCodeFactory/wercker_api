require 'spec_helper'

RSpec.describe WerckerAPI::Application, vcr: { cassette_name: :fetch_application } do
  let(:client) { WerckerAPI::Client.new }

  subject { client.application('StupidCodeFactory', 'wercker_api') }

  let(:expected_attributes) do
    {
      id:        '595a6b1ba01812010072fc1c',
      url:       'https://app.wercker.com/api/v3/applications/stupidcodefactory/wercker_api',
      name:      'wercker_api',
      deploys:   'https://app.wercker.com/api/v3/applications/stupidcodefactory/wercker_api/deploys',
      builds:    'https://app.wercker.com/api/v3/applications/stupidcodefactory/wercker_api/builds',
      badgeKey:  '15fd697b0b3ff854e408a5c256e6737b',
      createdAt: Time.parse('2017-07-03T16:04:43.374Z'),
      updatedAt: Time.parse('2017-07-03T16:04:43.374Z'),
      theme: 'Amethyst',
      allowedActions: %w[delete_project update_project transfer_ownership_project update_checkout_key migrate_application list_authorizations create_authorization read_authorization update_authorization delete_authorization read_heroku_collaborators send_invites create_key delete_key update_key update_teams delete_team update_org create_member delete_member update_member create_team_members delete_team_members org_create_app org_transferownership_app org_transfer_apiUser_app update_project_button cancel_customer create_customer get_customer update_customer get_billing update_billing update_extended_permissions get_invoice list_invoices list_orginvitations create_orginvitation get_orginvitation delete_orginvitation resend_orginvitation deploy_build reset_deploy_warnings create_deploytarget create_target update_target delete_target create_target_trigger update_target_trigger read_target_trigger delete_target_trigger read_deploytarget abort_deploy update_deploytarget delete_deploytarget read_deploytargetsettings application_envcollection list_key read_key create_env_var update_env_var delete_env_var build_project rebuild_build abort_build read_deploy list_deploysteps read_deploystep read_deploytarget_logs add_pullrequest receive_push autodeploy_build fix_webhook clear_cache_project list_teams list_members org_read_wallItem read_docker_image create_run abort_run list_extended_permissions read_env_var read_project list_builds read_build list_runs read_run list_runsteps read_runstep list_buildsteps read_buildstep follow_project unfollow_project list_targets read_target list_workflows list_collaborators list_comment create_comment]
    }
  end

  it { is_expected.to have_attributes(expected_attributes) }
  describe 'complexe attributes' do
    describe '#settings' do
      specify do
        expect(subject.settings).to have_attributes(privacy: 'public', stack: 6, ignoredBranches: ['gh-pages'])
      end
    end

    describe '#scm' do
      specify do
        expect(subject.scm).to have_attributes(type: 'git', owner: 'StupidCodeFactory', domain: 'github.com', repository: 'wercker_api')
      end
    end

    describe '#owner' do
      specify do
        expect(subject.owner).to have_attributes(type: 'wercker', userId: '56a4de11212b43b24e0b6175', name: 'yann')
      end

      describe '#avatar' do
        specify do
          expect(subject.owner.avatar).to have_attributes(gravatar: 'a4346267407e112504b5dab1dac534ea')
        end
      end

      describe '#meta' do
        specify do
          expect(subject.owner.meta).to have_attributes(username: 'StupidCodeFactory', type: 'user', werckerEmployee: false)
        end
      end
    end
  end
end
