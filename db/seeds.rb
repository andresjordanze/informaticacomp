# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

	gerente = User.new
	gerente.username = 'gerente'
	gerente.name = 'gerente gerente'
	gerente.password = 'gerente123'
	gerente.rol = 'gerente'
	gerente.save!

	admin = User.new
	admin.username = 'admin'
	admin.name = 'Administrador Admin'
	admin.password = 'admin123'
	admin.rol = 'admin'
	admin.save!

	secretaria = User.new
	secretaria.username = 'secre'
	secretaria.name = 'Secretaria Secre'
	secretaria.password = 'secre123'
	secretaria.rol = 'secre'
	secretaria.save!

	almacenero = User.new
	almacenero.username = 'almacenero'
	almacenero.name = 'Almacen Alma'
	almacenero.password = 'almacen123'
	almacenero.rol = 'enc_almacen'
	almacenero.save!		

	brands = Brand.create([{name: "Toshiba"}, {name: "Dell"}, {name: "Sony"}, {name: "3M"}, {name: "ASUS"}, {name: "Samsung"}, {name: "ViewSonic"}, {name: "Amazon"}, {name: "Apple"}, {name: "eBeam"}, {name: "Epson"}, {name: "BenQ"}, {name: "NEC"}, {name: "HP"}])
	categories = Category.create([{name: "Laptops"}, {name: "Maletines"}, {name: "Mochilas"}, {name: "Accesorios"}, {name: "Impresoras"}, {name: "Proyectores"}, {name: "Tablets"}, {name: "Mobiliarios"}])
# Lista de Clientes

	client1 = Client.new
	client1.name = 'Andres Jordan'
	client1.nit = 1234567
	client1.phone = 4489290
	client1.save!

	client2 = Client.new
	client2.name = 'Oscar Gonzalez'
	client2.nit = 2234567
	client2.phone = 3489101
	client2.save!

#Lista de proveedores

	prov1 = Provider.new
	prov1.name = 'Toshiba'
	prov1.phone = 1234567
	prov1.mail = 'toshiba@hotmail.com'
	prov1.address = 'Miami'
	prov1.save!

	prov2 = Provider.new
	prov2.name = 'Dell'
	prov2.phone = 7654321
	prov2.mail = 'dell@yahoo.com'
	prov2.address = 'Washigton'
	prov2.save!

	prov3 = Provider.new
	prov3.name = 'Apple'
	prov3.phone = 7890123
	prov3.mail = 'apple@yahoo.com'
	prov3.address = 'California'
	prov3.save!

#Lista de productos
