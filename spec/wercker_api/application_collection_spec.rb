require 'spec_helper'

RSpec.describe WerckerAPI::ApplicationCollection do
  it { is_expected.to respond_to(:each) }
end
