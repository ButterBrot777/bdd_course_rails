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

  # rubocop:disable Metrics
  def create
    if !current_user
      flash[:alert] = 'Please sign in or sign up first'
      redirect_to new_user_session_path
    else
      @comment = @article.comments.build(comment_params)
      @comment.user = current_user
      if @comment.save
        flash[:success] = 'Comment has been created'
      else
        flash.now[:alert] = 'Comment has not been created'
      end
      redirect_to article_path(@article)
    end
  end
  # rubocop:enable Metrics

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
