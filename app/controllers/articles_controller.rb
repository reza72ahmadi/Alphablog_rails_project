class ArticlesController < ApplicationController
    def index
      # @articles = Article.all
       @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def show
      @article = Article.find(params[:id])
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
      @article = Article.find(params[:id])
    end

    def update
      @article = Article.find(params[:id])

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

      redirect_to articles_path, status: :see_other
    end

    private
    def article_params
      params.require(:article).permit(:title, :body)
    end
end

