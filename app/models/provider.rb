class Provider < ActiveRecord::Base
	attr_accessible :name, :mail, :phone, :address
	validates :name, presence: {:message => "Usted debe ingresar el nombre de proveedor"}
	validates :name, uniqueness: {case_sensitive: false, :message => "El proveedor ya existe"}
	validates :name, format: { with: /\A[a-zA-Z\d\s]+\z/,
    message: "Solo Letras Permitidas" }

    validates :phone, numericality: {:message => "El valor de telefono/celular debe ser numerico"}
    validates :phone, length: {minimum: 7, maximum: 8, :message => "El numero de telefono/celular debe tener minimo 7 y maximo 8 numeros"}
    validates :phone, numericality: {greater_than: 0, :message => "El numero de telefono/celular no puede ser un numero negativo" }

    validates :address, presence: {:message => "Usted debe ingresar la direccion de proveedor"}

	def correspondeAnombre(nombre)
    	parametros = nombre.split(' ')
    	parametros.each do |parametro|
      	if self.name.downcase.include?(parametro.downcase)
	        return true
    	  end
    	end
    	false
  	end

end
