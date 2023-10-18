class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destory]
  before_action :require_user, except: [:show, :index] 
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new 
    @article = Article.new
  end

  def create
    @article = Article.new(article_params) 
    @article.user = User.first
    if @article.save
      flash[:notice] = 'Article successfuly created'
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article successfuly updated'
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = 'Article successfuly deleted'
    redirect_to articles_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end

    def set_article
      @article = Article.find(params[:id])
    end

    def require_same_user
      if current_user != @article.user
        flash[:alert] = 'You can only edit or delete your own rticle'
        redirect_to @article
      end
    end
    
end



