# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  def index
    @articles = Article.order(:asc)
  end

  def new
    @article = Article.new
  end

  def show
    @comment = @article.comments.build
    @comments = @article.comments
  end

  def edit
    # rubocop:disable Style/GuardClause
    unless @article.user == current_user
      flash[:alert] = 'You can only edit your own article.'
      redirect_to root_path
    end
    # rubocop:enable Style/GuardClause
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = 'Article has been created'
      redirect_to articles_path
    else
      flash.now[:danger] = 'Article has not been created'
      render :new
    end
  end

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Style/IfInsideElse
  def update
    if @article.user != current_user
      flash[:danger] = 'You can only edit your own article.'
      redirect_to root_path
    else

      if @article.update(article_params)
        flash[:success] = 'Article has been updated'
        redirect_to @article
      else
        flash.now[:danger] = 'Article has not been updated'
        render :edit
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Style/IfInsideElse

  def destroy
    # rubocop:disable Style/GuardClause
    if @article.destroy
      flash[:success] = 'Article has been deleted.'
      redirect_to articles_path
      # rubocop:enable Style/GuardClause
    end
  end

  protected

  def resource_not_found
    flash[:alert] = 'The article you are looking for could not be found'
    redirect_to root_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
