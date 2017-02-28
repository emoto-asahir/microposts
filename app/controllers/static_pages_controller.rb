class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(5)
    else
      @feed_items = Micropost.all.order(created_at: :desc).page(params[:page]).per(5)
    end
  end
  
  def all_microposts
    @feed_items = Micropost.all.order(created_at: :desc).page(params[:page]).per(5)
  end
end
