class ProductsController < ApplicationController
    before_action :search
    
    def payment
        @product = Product.find(params[:id])
    end
    
    def pay
        @product = Product.find(params[:id])
        @product.update(status: @product.status - 1)
         
        flash[:notice] = '購入が完了しました。' 
        redirect_to root_path
    end
    
    # いいね処理
    def like
        # ここに処理を実装
        @product = Product.find(params[:id])
          
        if UserLike.exists?(product_id: @product.id, user_id: current_user.id)
            # いいねを削除
            UserLike.find_by(product_id: @product.id, user_id: current_user.id).destroy
            
        else
            # いいねを登録
            UserLike.create(product_id: @product.id, user_id: current_user.id)
            
        end
            redirect_to products_path
    end

    def destroy
        @product = Product.find(params[:id])
            if @product.destroy
                flash[:notice] = "商品を削除しました。"
                redirect_to user_path(current_user) and return
            else 
                flash[:danger] = "削除に失敗しました"
            end
                redirect_to product_path and return
    end
    
    def index
            @q = Product.ransack(params[:q])
            @q.sorts = ['updated_at desc'] if @q.sorts.empty?
            @product = @q.result
            @categories = Category.all
           
    end
     
    def search
        if params[:q].present?
            # 検索フォームからアクセスした時の処理
              @search = Product.ransack(search_params)
              @product = @search.result
        else
            # 検索フォーム以外からアクセスした時の処理
              params[:q] = { sorts: 'id desc' }
              @search = Product.ransack()
              @product = Product.all
        end
    end

    def search_params
        params.require(:q).permit(:sorts)
    end
    
    def show
        @product = Product.find(params[:id])
        
    end
    
    def edit
         @product = Product.find(params[:id])
         @category = Category.all
    end
    
    def update
           @product = Product.find(params[:id])
        if @product.update(product_params)
            flash[:notice] = "更新しました"
                redirect_to product_path(@product.id) and return
        else
            flash[:notice] = "更新できませんでした。"
                redirect_to edit_product_path(@product.id) and return
        end
    end
    
    def new
        @product = Product.new
        @category = Category.all
    end
    
    def create
        @product = Product.new(product_params)
    if  @product.save!
            flash[:notice] = "出品しました。"
                redirect_to product_path(id: @product.id) and return
    else
            flash[:danger] = "出品できませんでした"
                redirect_to new_product_path and return
    end
    end
    
    private
    
    def product_params
            params.require(:product).permit(:name,:description,:price,:category_id,:image1).merge(user_id: current_user.id, status: 1)
    end
end
