require 'test_helper'
require 'channel'

class SlackChannelTest < ActionController::TestCase
  # just to verify that rake can pick up tests.
  test "the truth" do
    assert true
  end

  # test case for negative.
  test "You must provide a name and ID for Slack_Channel" do

    assert_raises ArgumentError do
      Slack_Channel.new nil, nil
    end

    assert_raises ArgumentError do
      Slack_Channel.new "", ""
    end

    assert_raises ArgumentError do
      Slack_Channel.new "", "12345"
    end

    assert_raises ArgumentError do
      Slack_Channel.new "slack-api-test", ""
    end

    assert_raises ArgumentError do
      Slack_Channel.new "slack-api-test", nil
    end
    assert_raises ArgumentError do
      Slack_Channel.new nil, "12345"
    end
  end

  test "Name attribute is set correctly" do
    test_me = Slack_Channel.new "myname", "myid"
    assert test_me.name == "myname"
  end

  test "ID attribute is set correctly" do
    test_me = Slack_Channel.new "myname", "myid"
    assert test_me.id == "myid"
  end






end
