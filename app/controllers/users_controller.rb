class UsersController < ApplicationController
    
    def likes
        @user = User.find(params[:id])
        @product = @user.products.includes(:users)
    end
    
    def index
        @user = User.find(current_user.id)
        @product = Product.where(user_id: @user)
    end
  
    def show
        @product = Product.where(user_id: params[:id]).order(created_at: :desc) 
    end
  
  
  
    def new
        @user = User.new
    end
  
  
    def edit
        @user = User.find(current_user.id)
    end
 
    def update
        if current_user.update(user_params)
   
            flash[:notice] = "更新しました"
            sign_in(current_user, bypass: true)
            redirect_to users_path and return
        else
            flash[:notice] = "更新できませんでした。"
            redirect_to edit_user_path and return
        end
    end

     # パラメータを取得
    def user_params
      params.require(:user).permit(:name, :profile, :image, :password, :password_confirmation)
    end
    
      
end
