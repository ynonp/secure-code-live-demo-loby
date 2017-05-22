class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :verify_signed_in_user

  # GET /items
  def index
    @items = Item.all.order(:created_at => :desc)
  end

  # GET /items/1
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  def create
    credits = session[:credits].to_i || 0
    if credits > 0
      session[:credits] = credits - 1
    else
      raise 'Not enough credits'
    end

    @item = Item.new(item_params)
    save_uploaded_image if params[:item][:image]

    respond_to do |format|
      if @item.save
        format.html { redirect_to items_path }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /items/1
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /items/1
  def destroy
    @item = Item.find(params[:id])
    raise 'Not your item!' unless @item.user == current_user

    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.fetch(:item, {}).permit(:name, :description, :image).merge(:user_id => current_user.id, :price => 0).except(:image)
  end

  def save_uploaded_image
    uploaded_io = params[:item][:image]
    filepath = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    File.open(filepath, 'wb') do |file|
      file.write(uploaded_io.read)
    end
    @item.image_path = "/uploads/#{uploaded_io.original_filename}"
  end
end
