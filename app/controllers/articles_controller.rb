class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destory]
    

    def index
      # @articles = Article.all
       @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def show
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)
      @article.user = current_user
      if @article.save
        flash[:notice]="Article was created successfuly"
        redirect_to @article
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update

      if @article.update(article_params)
        flash[:notice]="Article was updated successfuly"
        redirect_to @article
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to articles_path
    end

    private
    def article_params
      params.require(:article).permit(:title, :body)
    end

    def set_article
      @article = Article.find(params[:id])
    end

    def require_same_user 
      if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own articles"
      redirect_to @article
      end
    end

end

