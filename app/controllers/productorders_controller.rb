class ProductordersController < ApplicationController
  def index
    @productorders = Productorder.all
    @productorders = Productorder.order(params[:sort])
  end

  def show
   	@productorder = Productorder.find(params[:id])
	end

  def new
   	@productorder = Productorder.new
	end

  def edit
   	@productorder = Productorder.find(params[:id])
  end

  def create
    @control = false
    @order = Order.find(params[:order_id])
    @productname = Productname.find(params[:productorder][:nombre_producto])
    @productorders = Productorder.where("order_id = :order_id", {order_id: @order.id}).to_a
    @productorders.each do |productorder|
      if productorder.code == @productname.code
        @control = true
      end
    end
    if @control == false
      @productorder = Productorder.new(params[:productorder])
      @productorder.nombre_producto = @productname.name
      @productorder.code = @productname.code
      @productorder.description = @productname.description
      @productorder.ingresado = false
      @productorder.order_id = @order.id
      @productorder.total_price = params[:productorder][:quantity].to_i*params[:productorder][:price].to_i
      @productorder.save
      if params[:productorder][:control] == "true"
        redirect_to '/orders/'+@order.id.to_s+'/edit'
      else
        redirect_to '/orders/'+@order.id.to_s
      end
    else
      if params[:productorder][:control] == "true"
        flash[:danger] = 'No se registro el producto, porque ya existe en pedido'
        redirect_to '/orders/'+@order.id.to_s+'/edit'
      else 
        flash[:danger] = 'No se registro el producto, porque ya existe en pedido'
        redirect_to '/orders/'+@order.id.to_s
      end
    end
  end

  def update
    @productorder = Productorder.find(params[:id])
    @productorder.total_price = params[:productorder][:quantity].to_i*params[:productorder][:price].to_i
  	if @productorder.update_attributes(params[:productorder])
      flash[:success] = "Producto de pedido modificado!"
      if params[:control]='true'
        redirect_to '/orders/'+@productorder.order_id.to_s
      else
        redirect_to @productorder
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
