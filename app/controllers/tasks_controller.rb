class TasksController < ApplicationController
  before_action :set_board
  before_action :set_task, only: %i[edit update destroy]

  def new
    @task = @board.tasks.build
  end

  def create
    @task = @board.tasks.build(task_params)
    @task.user = current_user
    if @task.save
      redirect_to board_path(@board), notice: '作成されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to board_path(@board), notice: '更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to board_path(@board), notice: '削除されました'
  end

  def show
    @task = @board.tasks.find(params[:id])
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_task
    @task = @board.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :eyecatch)
  end
end
