module UsersHelper
    
    # プロフィール画像がなかったらダミー画像を指定する
def image_url(user)
  if user.image.blank?
    "https://dummyimage.com/200x200/000/fff"
  else
   @user.image
  end
end
end
