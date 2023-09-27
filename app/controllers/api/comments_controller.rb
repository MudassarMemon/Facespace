class Api::CommentsController < ApplicationController
    wrap_parameters include: Comment.attribute_names + ["authorId", "postId"]

    def show
        @comment = Comment.find_by(id: params[:id])
        render 'api/comments/show'
    end

    def index
        @comments = Comment.all
        render 'api/comments/index'
    end

    def create
        @comment = Comment.new(comment_params)

        if @comment.save
            render "api/comments/show"
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @comment = Comment.find_by(id: params[:id])

        if @comment.author_id == current_user.id
            @comment.destroy 
            render json: { message: 'success' }
        else
            render json: { errors: ['Something went wrong'] }, 
            status: :unauthorized
        end 
    end

    private

    def comment_params
        params.require(:comment).permit(:body, :author_id, :post_id)
    end

end