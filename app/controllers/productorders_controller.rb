class ProductordersController < ApplicationController
  def index
    @productorders = Productorder.all
    @productorders = Productorder.order(params[:sort])
  end

  def show
   	@productorder = Productorder.find(params[:id])
    @brand  = Brand.find(@productorder.brand_id)
	end

  def new
   	@productorder = Productorder.new
	end

  def edit
   	@productorder = Productorder.find(params[:id])
  end

  def create
    if params[:productorder][:control] == "true"
      @productorder = Productorder.find(params[:productorder][:id])
      @productorder.quantity = params[:productorder][:quantity]
      @productorder.price = params[:productorder][:price]
      @productorder.order_id = params[:order_id]
      @productorder.total_price = @productorder.quantity * @productorder.price
      @productorder.save
      redirect_to '/orders/'+@productorder.order_id.to_s
    else
      @brand = Brand.find(params[:productorder][:brand_id].to_i)
      @productorder = @brand.productorders.create(params[:productorder])
      @productorder.quantity = 1
      if @productorder.save 
        flash[:success] = "Producto creado exitosamente!"
        redirect_to productorder_path(@productorder)
      else
        render action: "new"
      end
    end
  end

  def update
    @productorder = Productorder.find(params[:id])
    @productorder.total_price = params[:productorder][:quantity].to_i*params[:productorder][:price].to_i
  	if @productorder.update_attributes(params[:productorder])
      flash[:success] = "Producto de pedido modificado!"
      if params[:control] = 'true'
        if params[:valor] = 'true'
          redirect_to '/orders/'+@productorder.order_id.to_s+'/edit'
        else
          redirect_to '/orders/'+@productorder.order_id.to_s
        end
      else
        if params[:valor] = 'true'
          redirect_to '/orders/'+@productorder.order_id.to_s+'/edit'
        else
          redirect_to '/orders/'+@productorder.order_id.to_s
        end
      end
    else
      render action: "edit" 
    end
  end

  def edit_order
    @productorder = Productorder.find(params[:id])
  end

  def update_order
    @productorder = Productorder.find(params[:id])
    if @productorder.update_attributes(params[:productorder])
      flash[:success] = "Producto de pedido modificado!"
      redirect_to '/orders/'+@productorder.order_id.to_s
    else
      render action: "edit" 
    end
  end
  
  def destroy
    @productorder = Productorder.find(params[:id])
    @productorder.destroy
    redirect_to productorders_url 
  end


  def agregar_producto_pedido
    @productorder = Productorder.find(params[:id])
    @productorder.order_id = params[:order_id]
    @productorder.ingresado = false
    @productorder.save
    @order = Order.find(params[:order_id])
    @order.save
    redirect_to order_path(@order)
  end

  def eliminar_producto_pedido
    @productorder = Productorder.find(params[:id])
    @productorder.order_id = nil
    @productorder.save
    @order = Order.find(params[:order_id])
    @order.save
    redirect_to order_path(@order)
  end
end
