require 'test_helper'

class PunchLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @punch_log = punch_logs(:one)
  end

  test "should get index" do
    get punch_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_punch_log_url
    assert_response :success
  end

  test "should create punch_log" do
    assert_difference('PunchLog.count') do
      post punch_logs_url, params: { punch_log: { card_type: @punch_log.card_type, card_uid: @punch_log.card_uid } }
    end

    assert_redirected_to punch_log_url(PunchLog.last)
  end

  test "should show punch_log" do
    get punch_log_url(@punch_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_punch_log_url(@punch_log)
    assert_response :success
  end

  test "should update punch_log" do
    patch punch_log_url(@punch_log), params: { punch_log: { card_type: @punch_log.card_type, card_uid: @punch_log.card_uid } }
    assert_redirected_to punch_log_url(@punch_log)
  end

  test "should destroy punch_log" do
    assert_difference('PunchLog.count', -1) do
      delete punch_log_url(@punch_log)
    end

    assert_redirected_to punch_logs_url
  end
end
