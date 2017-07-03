require 'spec_helper'

RSpec.describe WerckerAPI::Application do
  let(:client) { WerckerAPI::Client.new }

  it 'fetches all the applications' do
    expect(client.applications).to eq('somethin')
  end
end
