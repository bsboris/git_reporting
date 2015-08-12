require "test_helper"

module GitReporting

  describe MessageParser do
    subject { MessageParser }

    it "parse_at_the_be_beginning" do
      subject.parse("[1h] Message ").first.must_equal "Message"
    end

    it "parse_in_the_middel" do
      subject.parse("Message 1 [1h] Message 2").first.must_equal "Message 1  Message 2"
    end

    it "parse_with_any_number_of_spaces" do
      subject.parse("[1h]         Message    ").first.must_equal "Message"
      subject.parse("     [1h]         Message    ").first.must_equal "Message"
    end

    it "parse_multiline_messages" do
      subject.parse("Message [1h]\nMessage2").first.must_equal "Message \nMessage2"
    end

    it "strip_all_time_markers" do
      subject.parse("Message [1h] [2h]").first.must_equal "Message"
    end

    it "parse_message_without_time_marker" do
      subject.parse("Message").first.must_equal "Message"
    end

    it "parses_hours" do
      subject.parse("Message [1h]").last.must_equal 1.hour
    end

    it "parses_hours_and_minutes" do
      subject.parse("Message [1h 15m]").last.must_equal 75.minutes
    end

    it "parses_minutes" do
      subject.parse("Message [15m]").last.must_equal 15.minutes
    end

    it "parses_zero" do
      subject.parse("Message [0]").last.must_equal 0
    end

    it "parses_empty_string" do
      subject.parse("").last.must_equal nil
    end

    it "parses_nil" do
      subject.parse(nil).last.must_equal nil
    end

    it "parses_invalid_string" do
      subject.parse("nothing to see here").last.must_equal nil
    end

    it "parses_at_the_be_beginning" do
      subject.parse("[1h] Message ").last.must_equal 1.hour
    end

    it "parses_only_the_first_marker" do
      subject.parse("Message [1h] [2h]").last.must_equal 1.hour
    end

    it "doesnt_parse_other_markers" do
      subject.parse("Message [ci skip]").last.must_equal nil
      subject.parse("Message [#3123213]").last.must_equal nil
    end

    it "support custom prefix" do
      GitReporting.configure { |c| c.prefix = "spent" }
      parsed = subject.parse("Message [spent 3h]")

      parsed.first.must_equal "Message"
      parsed.last.must_equal 3.hours
    end
  end

end
