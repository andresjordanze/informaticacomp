class Brand < ActiveRecord::Base
	attr_accessible :name
	validates :name, presence: {:message => "Usted debe ingresar el nombre de la marca"}	
	validates :name, uniqueness: {case_sensitive: false, :message => "La marca ya existe"}

	validates :name, format: { with: /\A[a-zA-Z]+\z/,
    message: "Solo Letras Permitidas" }
end
