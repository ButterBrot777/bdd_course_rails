# frozen_string_literal: true

class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = 'Article has been created'
      redirect_to articles_path
    else
      flash.now[:danger] = 'Article has not been created'
      render :new
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = 'Article has been updated'
      redirect_to @article
    else
      flash.now[:danger] = 'Article has not been updated'
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    return unless @article.destroy

    flash[:success] = 'Article has been deleted.'
    redirect_to articles_path
  end

  protected

  def resource_not_found
    flash[:alert] = 'The article you are looking for could not be found'
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
