class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        memo = Memo.find(params[:memo_id])
        comment = memo.comments.build(comment_params) #buildを使い、contentとmemo_idの二つを同時に代入
        comment.user_id = current_user.id
        if comment.save
            flash[:success] = "コメントしました"
            redirect_back(fallback_location: root_path)
        else
            flash[:success] = "コメントできませんでした"
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        @memofi = Memo.find(params[:memo_id])
        comment = @memofi.comments.find(params[:id])
        if current_user.id == comment.user.id
            comment.destroy
            redirect_back(fallback_location: root_path)
        else
            redirect_back(fallback_location: root_path)
        end
    end

    def edit
        @memofi = Memo.find(params[:memo_id])
        @comment = @memofi.comments.find(params[:id])
    end

    def update
        @memofi = Memo.find(params[:memo_id])
        @comment = @memofi.comments.find(params[:id])
        if @comment.update(comment_params)
            redirect_to memo_path(@memofi.id)
        else
            redirect_to memo_path(@memofi.id)
        end
    end

    private

        def comment_params
            params.require(:comment).permit(:content, :abstract, :diversion)
        end
end