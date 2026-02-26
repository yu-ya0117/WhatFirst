require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test "should get index" do
    get tasks_url
    assert_response :success
  end

  test "should get new" do
    get new_task_url
    assert_response :success
  end

  test "should create task" do
    assert_difference("Task.count") do
      # post tasks_url, params: { task: { completed: @task.completed, priority: @task.priority, title: @task.title } }
      post tasks_url, params: { task: { priority: @task.priority, title: @task.title } }
    end

    assert_redirected_to tasks_url
  end

  test "should show task" do
    get task_url(@task)
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(@task)
    assert_response :success
  end

  def test_cannot_complete_without_check
    patch task_url(@task), params: { task: { completed: "0" } }

    assert_redirected_to tasks_url
    follow_redirect!
    assert_match "完了するにはチェックを入れてください", response.body
  end

  # test "should destroy task" do
  #   assert_difference("Task.count", -1) do
  #     delete task_url(@task)
  #   end

  #   assert_redirected_to tasks_url
  # end
end
