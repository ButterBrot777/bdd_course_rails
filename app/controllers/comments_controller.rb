# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_article, only: %i[show edit create update destroy]

  def index
    @comments = Comment.all
  end

  def new; end

  def show
    @comments = @article.comments
  end

  def edit; end

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = 'Comment has been created'
    else
      flash.now[:alert] = 'Comment has not been created'
    end
    redirect_to article_path(@article)
  end

  def update; end
  def destroy; end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
