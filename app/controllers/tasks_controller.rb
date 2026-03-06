class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update complete ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.incomplete.order(priority: :asc)
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "タスクの作成が成功しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: notice_message
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  # def destroy
  #   @task.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to tasks_path, notice: "Task was successfully destroyed.", status: :see_other }
  #     format.json { head :no_content }
  #   end
  # end

  def complete
    if params.dig(:task, :completed) != "1"
      return redirect_to tasks_path, alert: "完了するにはチェックを入れてください。"
    end

    @task.update(completed: true)
    redirect_to tasks_path, notice: notice_message
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :priority, :completed)
    end

    def notice_message
      if @task.saved_change_to_completed?
        "タスクを完了しました"
      elsif @task.saved_change_to_title?
        "タスク名を変更しました"
      elsif @task.saved_change_to_priority?
        "優先度を変更しました"
      else
        "タスクを更新しました"
      end
    end
end
