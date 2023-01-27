class Public::ItemsController < ApplicationController

  def index
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = Item.where(genre_id:@genre.id).page(params[:page]).per(8).order(created_at: :desc)
    else
      @items = Item.page(params[:page]).per(8).order(created_at: :desc)
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  def search
    keyword = params[:keyword]
    if keyword == ""
      redirect_to items_path
    else
      @items = Item.search(keyword).page(params[:page]).per(8)
      @genres = Genre.all
    end
  end

end
