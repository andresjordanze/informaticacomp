class ProductsController < ApplicationController
	def index
		@products = Product.all		
	end

	def show
		@product = Product.find(params[:id])
	end	

	def inventario
		@products = Product.all
	end

	def new
		@product = Product.new
		@order = Order.find(params[:id])
	end

	def search
		@products = buscar(params[:name])
		render 'index'
	end

	def buscar(nombre)
    	items = Array.new	
    	aux = Product.all
    	if nombre != "" && nombre != nil
      		aux.each do |item|
        	if (item.correspondeAnombre(nombre))
          		items.push(item)
        	end
      	end
    	else
      		items = aux
    	end
    	return items
  	end

  	def search_to_home
		@products = buscar_por_nombre(params[:name])
		render 'products_home'
	end

	def buscar_por_nombre(nombre)
    	items = Array.new	
    	aux = Product.all
    	if nombre != "" && nombre != nil
      		aux.each do |item|
        	if (item.correspondeApagina(nombre))
          		items.push(item)
        	end
      	end
    	else
      		items = aux
    	end
    	return items
  	end

  	def registrar_ingreso
  		@products = Product.all
  		@productorder = Productorder.find(params[:id])
  		@income = Income.new
  		@income.registrar(params[:id])
  		@income.save
  		control = false
  		if @products != []
	  		@products.each do |producto|
	  			if producto.general_code == @productorder.code
	  				producto.quantity += @productorder.quantity
	  				producto.save
	  				@product = producto
	  				@productorder.ingresado = true
	  				@productorder.save
	  				control = true
	  			else
	  				@product = Product.new
	  			end
	  		end
	  		if control == false
	  			render "new"
	  		else
	  			redirect_to @product, notice: 'Ingreso registrado!'	  		
	  		end
	  	else
	  		@product = Product.new
	  		render 'new'
	  	end
  	end


	private
	def increase
		if @product.quantity == 0
			i = @product.quantity
			i+=1
		else
			i = @product.quantity
		end
    	@product.quantity = @product.quantity + @product.increase
    	while i < @product.quantity do
      		@product.subproducts.create("code" => @product.general_code + "-#{i}")
      		i = i + 1
    	end
    	@product.increase = 0
    	@product.save
	end
	
	public

	def create
		@product = Product.new(params[:product])
		@productorder = Productorder.find(params[:product][:id])	
		@productorder.ingresado = true
		@productorder.save
		@product.home = false
		@product.description = "          "
		if @product.save		
			redirect_to @product, notice: 'Producto creado correctamente.' 
		else
			render action: 'new'
		end
	end
	
	def edit_to_home
		@product = Product.find(params[:id])
	end
	
	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		if @product.update_attributes(params[:product])
			@product.save
			flash[:success] = "Producto Actualizado"
			if params[:product][:control]=='true'
				redirect_to '/products_home'
			else
				redirect_to @product
			end			
		else
			if params[:product][:control]=='true'
				redirect_to '/add_to_home?id='+@product.id.to_s
			else
				render 'edit'
			end
		end
	end

#params[:name], params[:detail], params[:quantity],params[:general_code], params[:brand], params[:category], params[:bought_price],params[:sale_price], params[:created_at], params[:updated_at]
	#def update 
	#	@product = Product.find(params[:id])
	#	if @product.update_attributes(params[:empleado])
	#		@product.save			
	#		if(@product.update_attributes(params[:photo], params[:description]))
	#			flash[:success] = "Producto de Pagina Actualizado"	
	#			redirect_to :controller => :products, :action => 'products_home'	
	#		else
	#			flash[:success] = "Producto Actualizado"
	#			redirect_to @product	
	#		end
	#	else
	#		render 'edit'
	#	end
	#end

	def 
		@products = Product.all
	end

	def view_product
		@product = Product.find(params[:id])
	end

	def add_to_home
		@product = Product.find(params[:id])
		@product.home = true
		@product.save		
	end
	

	def delete_from_home
		@product = Product.find(params[:id])
		@product.home = false
		@product.description =''
		@product.save
		redirect_to :controller => :products, :action => 'index'
		
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		redirect_to products_url
	end
end
