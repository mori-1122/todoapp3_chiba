class CommentsController < ApplicationController
  before_action :authenticate_user! # #ユーザー認証
  before_action :set_task # どのタスクに対するコメントかを特定

  # 新規コメントフォームを表示
  def new # #メソッド定義
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:task_id])
    @comment = Comment.new
  end

  def create # #メソッド定義
    @task = Task.find(params[:task_id])
    @comment = @task.comments.build(comment_params) # コメントの内容を受け取る
    @comment.user = current_user # コメントの投稿者を設定

    if @comment.save # #コメントをデータベースに保存する
      redirect_to board_task_path(@task.board, @task), notice: '追加しました' ## コメントの保存に成功したら、タスクの詳細ページにリダイレクト（遷移）
    else
      redirect_to board_task_path(@task.board, @task), notice: '追加できませんでした'
    end
  end

  def destroy # #メソッド定義
    @comment = @task.comments.find(params[:id]) # #削除対象のコメントを @task.comments の中から探す
    if comment.user == current_user # コメント投稿した人が、今のユーザーかどうか
      @comment.destroy
      redirect_to board_task_path(@task.board, @task), notice: '削除しました' # 成功時
    else
      redirect_to board_task_path(@task.board, @task), notice: '削除できません' # 失敗時
    end
  end

  private

  # どのタスクに対するコメントかを特定する
  def set_task
    @board = Board.find(params[:board_id]) # 親のボードを取得
    @task = @board.tasks.find(params[:task_id]) # ボード内のタスクを取得
  end

  # フォームから送信されるコメントのデータを安全に受け取る
  def comment_params
    params.require(:comment).permit(:content)
  end
end
