class Public::ItemsController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @items = Item.all
    @genre = Genre.all
  end
end
