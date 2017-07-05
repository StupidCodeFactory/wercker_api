require 'net/http'
require 'json'
module WerckerAPI
  class WerckerAPI::Error < ArgumentError
    def initialize(response)
      json = JSON.parse(response.body)
      msg = <<-EOM
Error: #{json['error']}, status: #{json['statusCode']}, message: #{json['message']}
EOM
      super(msg)
    end
  end

  class Client
    API_ENDPOINT = URI('https://app.wercker.com').freeze

    def initialize(token = nil, api_version = 'v3')
      self.api_token = token || ENV['WERCKER_API_TOKEN']
      raise_token_nil_error if api_token.nil?
      self.api_version = api_version
    end

    # List user applications
    #
    # List all applications owned by the user or organization.
    # The result will only contain applications that the authenticated user has access to.
    # If the call is made without a token, only public applications will be returned.
    #
    # @param user_name [String] A wercker user name
    # @param params [Hash] Other params to pass as a query string to the API call
    # @return [WerckerAPI::ApplicationCollection] An enumerable the yields `WerkerAPI::Application`
    def applications(user_name, params = {})
      request(
        build_get_request(
          Application::INDEX[api_version, user_name], params
        ), ApplicationCollection
      )
    end

    # Get an application
    #
    # Get the details of a single application.
    #
    # @param user_name [String] A wercker user name
    # @param application [String] An wercker application name (probably a repository name).
    # @return [WerckerAPI::Application] A DAO wrapper around the API response.
    def application(user_name, application)
      request(
        build_get_request(
          Application::SHOW[api_version, user_name, application]
        ),
        Application
      )
    end

    # Update an application
    #
    # Update a single application. Currently it is only possible to change the ignored branches for the application. The updated application will be returned.
    #
    # @param user_name [String] A wercker user name
    # @param application [String] An wercker application name (probably a repository name).
    # @params branches [Array] An array of branches you want to ignore
    # @return [WerckerAPI::Application] A DAO wrapper around the API response.
    def update_application(user_name, application, branches)
      request(
        build_patch_request(
          Application::SHOW[api_version, user_name, application], ignoredBranches: branches
        ),
        Application
      )
    end

    # List builds
    #
    # Retrieve all builds of an application.
    #
    # @param user_name [String] A wercker user name
    # @param application [String] An wercker application name (probably a repository name).
    # @return WerckerAPI::Application::BuildCollection An enumerable yielding WerckerAPI::Application::Build objects
    def application_builds(user_name, application)
      request(
        build_get_request(
          Application::Build::INDEX[api_version, user_name, application]
        ),
        Application::BuildCollection
      )
    end

    # List deploys
    #
    # Retrieve all deploys of an application.
    #
    # @param user_name [String] A wercker user name
    # @param application [String] An wercker application name (probably a repository name).
    # @return WerckerAPI::Application::DeployCollection An Enumerable yielding WerckerAPI::Application::Deploy
    def application_deploys(user_name, application)
      request(
        build_get_request(
          Application::Deploy::INDEX[api_version, user_name, application]
        ),
        Application::DeployCollection
      )
    end

    # Get all workflows
    #
    # Get the last 10 workflows.
    #
    #
    # @param application_id [String] A worker application id as returned by an API call
    # @return WerckerAPI::Application::WorkflowCollection An Enumerable yeilding WerckerAPI::Application::Workflow
    def application_workflows(application_id)
      request(
        build_get_request(
          Application::Workflow::INDEX[api_version], applicationId: application_id
        ),
        Application::WorkflowCollection
      )
    end

    # Get a workflow
    #
    # Get the details of a single workflow.
    #
    # Returns a workflow object, which contains a collection of runs.
    # @param workflow_id [String] A wercker workflow id as returned by an API call
    # @return WerckerAPI::Application::Workflow object
    def application_workflow(workflow_id)
      request(
        build_get_request(
          Application::Workflow::SHOW[api_version, workflow_id]
        ),
        Application::Workflow
      )
    end

    # Get all runs
    #
    # Get the last 20 runs for a given pipeline or application.
    #
    # Returns an array of run objects.
    #
    #
    # An *application_id*:: or a *pipeline_id*:: is required!
    #
    # @param application_id [String] The ID of the application.
    # @param pipeline_id [String]
    # @param [Hash] params Other params passed as a query string to the API
    # @option params [Integer] :limit Specify how many run objects should be returned. Max: 20, default: 20
    # @option params [Integer] :skip Skip the first X runs. Min: 1, default: 0
    # @option params [Integer] :sort Valid values: *creationDateAsc*:: or *creationDateDesc*::. Default *creationDateDesc*::
    # @option params [Integer] :status Filter by status. Valid values: notstarted, *started*::, *finished*::, *running*::
    # @option params [Integer] :result Filter by result. Valid values: *aborted*::, *unknown*::, *passed*::, **failed::
    # @option params [Integer] :branch ilter by branch
    # @option params [Integer] :pipelineId Filter by pipeline
    # @option params [Integer] :commit Filter by commit hash
    # @option params [Integer] :sourceRun  Filter by source run
    # @option params [Integer] :author  Filter by Wercker username
    # @return WerckerAPI::RunCollection An enumerable yielding a WerckerAPI::Run object
    def runs(application_id: nil, pipeline_id: nil, params: {})
      if application_id
        params[:applicationId] = application_id
      elsif pipeline_id
        params[:pipelineId] = pipeline_id
      end
      request build_get_request(Run::INDEX[api_version], params), RunCollection
    end

    # Get a run
    #
    # Get the details of a single run.
    #
    # Returns a run object.
    #
    # @params run_id [String, Integer] An id as returned by an API call
    # @return WerckerAPI::Run object
    def run(run_id)
      request build_get_request(Run::SHOW[api_version, run_id]), Run
    end

    # Trigger a new run
    #
    # Trigger a new run for an application.
    #
    # Returns a run object.
    #
    # It is possible to add environment variables, which will be added to the run. The order of the array will be maintained, which makes it possible to use environment variables that were defined earlier. Any environment variables defined as part of the application or workflow will be overwritten, if using the same key.
    #
    # @param pipeline_id [String]  An id as returned by an API call
    # @param [Hash] params Other params to pass as in body as query string to the API call
    # @option params [String] sourceRunId The *id*:: of the run that should be used as input for this run, including artifacts. This is the same as *chaining*:: a pipeline.
    # @option params [String] branch The Git *branch*:: that the run should use. If not specified, the default branch will be used.
    # @option params [String] commitHash The Git commit hash that the run should used. *Requires branch*:: to be set. If not specified, the latest commit is fetched
    # @option params [String] message The message to use for the run. If not specified, the Git commit message is used.
    # @option params [Array] envVars Environment variables which should be added to run. Contains objects with *key*:: and *value*:: properties.
    # @return WerckerAPI::Run object
    def trigger_run(pipeline_id, params = {})
      params[:pipelineId] = pipeline_id
      request build_post_request(Run::TRIGGER[api_version], params), Run
    end

    def run_steps(run_id)
      request build_get_request(Run::STEPS[api_version, run_id]), Run::StepCollection
    end

    def trigger_run(pipeline_id)
      request build_post_request(Run::TRIGGER[api_version], pipelineId: pipeline_id), Run
    end

    # Abort a run
    #
    # Abort an already running run instance.
    #
    # Returns an object.
    #
    # @param run_id [String] An id as returned by an API call
    # @return WerckerAPI::Run object
    def abort_run(run_id)
      request build_put_request(Run::ABORT[api_version, run_id]), Run
    end

    private

    attr_accessor :api_token, :api_version

    def http_client
      @http_client ||= build_http_client
    end

    def raise_token_nil_error
      msg = <<-EOM
A token is required to communicate with the API, please refer to the read me.

   client = WerckerAPI::Client.new('2039e0239840239u0239uf0293v2093urbv0293urbv')

More inforation at: http://devcenter.wercker.com/docs/api/getting-started/authentication
EOM
      raise ArgumentError, msg
    end

    def build_get_request(uri, params = {})
      uri = URI::HTTP.build(path: uri, query: URI.encode_www_form(params))
      authorise_request(Net::HTTP::Get.new(uri))
    end

    def build_put_request(uri, params = {})
      request = Net::HTTP::Put.new(URI::HTTP.build(path: uri))
      build_request_with_body(request, params)
    end

    def build_patch_request(uri, params)
      request = Net::HTTP::Patch.new(URI::HTTP.build(path: uri))
      build_request_with_body(request, params)
    end

    def build_post_request(uri, params)
      request = Net::HTTP::Post.new(URI::HTTP.build(path: uri))
      build_request_with_body(request, params)
    end

    def build_request_with_body(request, params)
      request.body = JSON.dump(params)
      request['Content-Type'] = 'application/json'
      authorise_request(request)
    end

    def authorise_request(request)
      request['Authorization'] = "Bearer #{api_token}"
      request
    end

    def build_http_client
      http_client = Net::HTTP.new(API_ENDPOINT.host, API_ENDPOINT.port)
      http_client.use_ssl = true
      http_client
    end

    def request(request, serializer)
      handle(http_client.request(request), serializer)
    end

    def handle(response, klass)
      case response
      when Net::HTTPSuccess
        klass.new(JSON.parse(response.body))
      else
        handle_error(response)
      end
    end

    def handle_error(response)
      raise WerckerAPI::Error, response
    end
  end
end
