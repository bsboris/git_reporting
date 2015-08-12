require "test_helper"

module GitReporting

  describe Commit do
    subject { Commit }

    it "sets time to 0 by default" do
      subject.new.time.must_equal 0
    end

    it "parses message" do
      commit = subject.new(message: "Test commit [1h 30m]")

      commit.message.must_equal "Test commit"
      commit.time.must_equal 90.minutes
    end

    it "doesnt override time with nil" do
      commit = subject.new(time: 30.minutes)
      commit.message = "Test commit"

      commit.message.must_equal "Test commit"
      commit.time.must_equal 30.minutes
    end
  end

end
