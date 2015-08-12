require "test_helper"

module GitReporting::Source

  describe Github do
    subject { Github }

    it "fetches all commits" do
      VCR.use_cassette("bsboris_metazilla_all") do
        subject.new(repo: "bsboris/metazilla").fetch_all.wont_be :empty?
      end
    end

    it "fetches commits for period" do
      VCR.use_cassette("bsboris_metazilla_period") do
        subject.new(repo: "bsboris/metazilla").fetch(Date.new(2015, 7, 23)..Date.new(2015, 7, 24)).size.must_equal 9
      end
    end

    it "requires repo option" do
      proc { subject.new }.must_raise ArgumentError
    end

    it "passes options to client" do
      source = subject.new(repo: "test/test", login: "login", access_token: "token")

      source.client.login.must_equal "login"
      source.client.access_token.must_equal "token"
    end
  end

end
