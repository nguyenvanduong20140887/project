class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all.page params[:page]
    @cart = current_cart
    @top_reviews = Product.all.order(:overall_rating => :desc)
    @top_views = Product.all.order(:view_count => :desc)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @is_favorited = @product.is_favorited(current_user)
    @reviews = @product.reviews.to_a

    @product = Product.find_by_id params[:id]
    recent_products.push @product #=> Đẩy 1 product vừa xem vào collection

    view_count = @product.view_count + 1
    @product.update_attributes(view_count: view_count)

    # Lấy toàn bộ danh sách
    recent_products

    @similar_products = Product.search("#{@product.product_category_tree.split(/>>/).reverse.second}")
    ssize = @similar_products.size
    @product1 = @similar_products[rand(ssize)]
    @product2 = @similar_products[rand(ssize)]
    @product3 = @similar_products[rand(ssize)]
    @product4 = @similar_products[rand(ssize)]
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def product_for_women
    products = Product.search("women")
    @products = Kaminari.paginate_array(products).page(params[:page]).per(8)
  end

  def product_for_men
    products = Product.search("men")
    @products = Kaminari.paginate_array(products).page(params[:page]).per(8)
  end

  def sneakers_product
    products = Product.search("sneakers")
    @products = Kaminari.paginate_array(products).page(params[:page]).per(8)
  end

  def boots_product
    products = Product.search("boots")
    @products = Kaminari.paginate_array(products).page(params[:page]).per(8)
  end

  def shoes_product
    products = Product.search("shoes")
    @products = Kaminari.paginate_array(products).page(params[:page]).per(8)
  end

  def sandals_product
    products = Product.search("sandals")
    @products = Kaminari.paginate_array(products).page(params[:page]).per(8)
  end

  def flip_flops_product
    products = Product.search("flip flops")
    @products = Kaminari.paginate_array(products).page(params[:page]).per(8)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:uniq_id, :crawl_timestamp, :product_url, :product_name, :product_category_tree, :pid, :retail_price, :discounted_price, :image, :is_FK_Advantage_product, :description, :product_rating, :overall_rating, :brand, :product_specifications)
    end
end
