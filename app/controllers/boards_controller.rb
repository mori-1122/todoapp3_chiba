class BoardsController < ApplicationController
  before_action :authenticate_user! # ユーザー認証

  def index
    @boards = Board.all # user情報をあらかじめ読み込む
  end

  def show
    @board = Board.find(params[:id])
    @tasks = @board.tasks.order(created_at: :desc)
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, notice: '作成されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to boards_path, notice: '更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy!
    redirect_to boards_path, notice: '削除されました'
  end

  private

  def board_params
    params.require(:board).permit(:title, :description)
  end
end
