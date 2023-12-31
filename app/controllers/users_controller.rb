class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end
    def show
        @articles = @user.articles
    end

    def new
        @user = User.new
    end

    def edit
    end

    def update
        if @user.update(user_params)
        flash[:notice] = "Your profile updated successfuly"
        redirect_to articles_path
        else
            render 'edit'
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
        flash[:notice] = "Dear #{@user.username} you have successfuly signedup"
        redirect_to root_path
        else
            render 'new'
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Acount deldeted"
        redirect_to articles_path
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    
    def set_user
        @user = User.find(params[:id])
    end
    
    def require_same_user
        if current_user != @user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your own profile"
        redirect_to @user
        end
    end

end