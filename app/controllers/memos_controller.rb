class MemosController < ApplicationController
  before_action :authenticate_user!

  def index
    @memos = Memo.all

    @memos = if params[:search].nil?
               Memo.all.page(params[:page]).per(10)
             elsif params[:search] == ''
               Memo.all.page(params[:page]).per(10)
             else
               # 部分検索
               Memo.where('body LIKE ? ', '%' + params[:search] + '%').page(params[:page]).per(10)
             end
  end

  def new
    @memo = Memo.new
  end

  def create
    memo = Memo.new(memo_params)

    memo.user_id = current_user.id

    if memo.save
      redirect_to action: 'index'
    else
      redirect_to action: 'new'
    end
  end

  def show
    @memofi = Memo.find(params[:id])
    @comments = @memofi.comments
    @comment = Comment.new
  end

  def edit
    @memofi = Memo.find(params[:id])
  end

  def update
    memofi = Memo.find(params[:id])
    if memofi.update(memo_params)
      redirect_to action: 'show', id: memofi.id
    else
      redirect_to action: 'new'
    end
  end

  def destroy
    memofi = Memo.find(params[:id])
    memofi.destroy
    redirect_to action: :index
  end

  private

  def memo_params
    params.require(:memo).permit(:body, :images)
  end
end
