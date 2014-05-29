class ProvidersController < ApplicationController

	def index
    @providers = Provider.all
    @providers = Provider.order(params[:sort])
  end

  def show
  	@provider = Provider.find(params[:id])
	end

  
 	def new
   	@provider = Provider.new
	end

  	def edit
    	@provider = Provider.find(params[:id])
  	end

  	def create
    	@provider = Provider.new(params[:provider])
      if @provider.save
        flash[:success] = 'Proveedor creado exitosamente.'
       	redirect_to "/providers/"
      else
        render action: "new" 
      end
  	end

  def update
  	@provider = Provider.find(params[:id])
    if @provider.update_attributes(params[:provider])
	    flash[:success] = 'Proveedor editado exitosamente.'
      redirect_to "/providers/"
    else
    	render action: "edit" 
    end
  end

  
  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy
    redirect_to providers_url 
  end

  def search
    @providers = buscar(params[:name])
    render 'index'
  end

  def buscar(nombre)
      items = Array.new 
      aux = Provider.all
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

end
