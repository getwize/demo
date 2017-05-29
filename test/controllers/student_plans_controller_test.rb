require 'test_helper'

class StudentPlansControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get student_plans_new_url
    assert_response :success
  end

end
