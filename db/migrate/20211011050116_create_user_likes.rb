class CreateUserLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_likes do |t|
      
       t.references :product
       t.references :user

      t.timestamps
    end
  end
end
