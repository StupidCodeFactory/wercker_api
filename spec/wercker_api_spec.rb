require "spec_helper"
# curl --data-binary @$(ls -1 *.gem) -H "Authorization: $GEM_API_KEY" https://rubygems.org/api/v1/gems

RSpec.describe WerckerAPI do
  it "has a version number" do
    expect(WerckerAPI::VERSION).not_to be nil
  end

end
