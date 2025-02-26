class BoardsController < ApplicationController
  before_action :authenticate_user! # ユーザー認証

  def index
    @boards = Board.all # すべてのボードを取得
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, notice: "Board was successfully created."
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
      redirect_to boards_path, notice: "Board was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    board = Board.find(params[:id])
    # エラーが発生したら例外発生
    board.destroy!
    redirect_to boards_path, notice: "Board was successfully deleted."
  end

  private
  def board_params
    params.require(:board).permit(:title, :description)
  end
end
