require 'test_helper'
require 'slack_api_wrapper'
require 'channel'

class SlackApiTest < ActionController::TestCase
  test "the truth" do
    assert true
  end

  test "Can retrieve a list of channels" do
    VCR.use_cassette("channels") do
      channels = SlackApiWrapper.listchannels

      assert channels.is_a? Array
      assert channels.length > 0
      # can also do assert not empty.

      channels.each do |ch|
        assert ch.is_a? Slack_Channel
      end
    end
  end

  test "Retrieves nil when the token is wrong" do
    VCR.use_cassette("bad-token") do
      channels = SlackApiWrapper.listchannels "bad-token"
      assert channels == nil
    end
  end

  test "can send a properly formatted msg " do
    VCR.use_cassette("send-msg") do
      response = SlackApiWrapper.sendmsg("test-api-parens", "A smooth sea, never made a skilled sailor!")

      assert response["ok"]
      assert response["message"]["type"] == "message"
      assert response["message"]["subtype"] == "bot_message"
    end

  end

  test "A msg to non-existant channel fails. " do
    VCR.use_cassette("channel-doesnt-exist") do
      response = SlackApiWrapper.sendmsg("not-real-channel", "Ira Glass is god.")

      assert_not response["ok"]
      assert_not_nil response["error"], "channel_not_found"
    end

  end

  test "a non-existant Message fails" do
    VCR.use_cassette("bad-msg") do
      response = SlackApiWrapper.sendmsg("test-api-parens", "")
      assert_not response["ok"]
      assert_equal response["error"],
      "no_text"
      response = SlackApiWrapper.sendmsg("test-api-parens", nil)
      assert_not response["ok"]
      assert_equal response["error"],
      "no_text"
    end
  end

  test "testing a message with bad tolen fails" do
    VCR.use_cassette("bad-msg-token") do
      response = SlackApiWrapper.sendmsg("
      test-api-parens", "failed message", "")
      assert_not response["ok"]
      assert_equal response["ok"], "not_authed"
    end
  end






end
