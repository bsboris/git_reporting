$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "git_reporting"

require "minitest/autorun"
require "faker"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures/vcr"
  c.hook_into :webmock
  c.filter_sensitive_data("<GITHUB_LOGIN>") do
    test_github_login
  end
  c.filter_sensitive_data("<GITHUB_PASSWORD>") do
    test_github_password
  end
  c.filter_sensitive_data("<GITHUB_UID>") do
    test_github_uid
  end
  c.filter_sensitive_data("<GITHUB_TOKEN>") do
    test_github_token
  end
end

def test_github_login
  ENV.fetch('GITHUB_LOGIN', "github-user")
end

def test_github_password
  ENV.fetch('GITHUB_LOGIN', "x"*10)
end

def test_github_uid
  ENV.fetch('GITHUB_UID', "x"*21)
end

def test_github_token
  ENV.fetch('GITHUB_TOKEN', "x"*40)
end

class Minitest::Test
  def teardown
    GitReporting.reset_configuration!
  end

  def mock_commit(attrs = {})
    GitReporting::Commit.new(fake_commit_attributes(attrs))
  end

  def fake_commit_attributes(attrs = {})
    attrs[:sha] ||= Faker::Number.hexadecimal(40)
    attrs[:author] ||= Faker::Internet.user_name
    attrs[:time] ||= [15, 30, 45, 60].sample
    attrs[:timestamp] ||= Faker::Time.between(Time.current.beginning_of_month, Time.current.end_of_month)

    attrs
  end
end
