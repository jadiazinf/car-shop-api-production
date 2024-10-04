# # This file should ensure the existence of records required to
# # run the application in every environment (production,
# # development, test). The code here should be idempotent so that
# # it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed
# # command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end

Location.create!(
  [
    { name: 'Venezuela', location_type: 'country', parent_location_id: nil },
    { name: 'Miranda', location_type: 'state', parent_location_id: 1 },
    { name: 'Caracas', location_type: 'city', parent_location_id: 2 },
    { name: 'Las Minas de Baruta', location_type: 'town', parent_location_id: 3 },
    { name: 'Sucre', location_type: 'state', parent_location_id: 1 },
    { name: 'Cumana', location_type: 'city', parent_location_id: 5 },
    { name: 'San Luis', location_type: 'town', parent_location_id: 6 },
    { name: 'Anzoategui', location_type: 'state', parent_location_id: 1 },
    { name: 'Barcelona', location_type: 'city', parent_location_id: 8 },
    { name: 'Lecheria', location_type: 'town', parent_location_id: 9 },
    { name: 'Zulia', location_type: 'state', parent_location_id: 1 },
    { name: 'Maracaibo', location_type: 'city', parent_location_id: 11 },
    { name: 'Cabimas', location_type: 'town', parent_location_id: 12 },
    { name: 'Tachira', location_type: 'state', parent_location_id: 1 },
    { name: 'San Cristobal', location_type: 'city', parent_location_id: 14 },
    { name: 'Rubio', location_type: 'town', parent_location_id: 15 },
    { name: 'Merida', location_type: 'state', parent_location_id: 1 },
    { name: 'Merida', location_type: 'city', parent_location_id: 17 },
    { name: 'El Vigia', location_type: 'town', parent_location_id: 18 },
    { name: 'Trujillo', location_type: 'state', parent_location_id: 1 },
    { name: 'Trujillo', location_type: 'city', parent_location_id: 20 },
    { name: 'Valera', location_type: 'town', parent_location_id: 21 },
    { name: 'Lara', location_type: 'state', parent_location_id: 1 },
    { name: 'Barquisimeto', location_type: 'city', parent_location_id: 23 },
    { name: 'Cabudare', location_type: 'town', parent_location_id: 24 },
    { name: 'Portuguesa', location_type: 'state', parent_location_id: 1 },
    { name: 'Acarigua', location_type: 'city', parent_location_id: 26 },
    { name: 'Araure', location_type: 'town', parent_location_id: 27 },
    { name: 'Yaracuy', location_type: 'state', parent_location_id: 1 },
    { name: 'San Felipe', location_type: 'city', parent_location_id: 29 },
    { name: 'Chivacoa', location_type: 'town', parent_location_id: 30 },
    { name: 'Cojedes', location_type: 'state', parent_location_id: 1 },
    { name: 'San Carlos', location_type: 'city', parent_location_id: 32 },
    { name: 'Tinaquillo', location_type: 'town', parent_location_id: 33 },
    { name: 'Carabobo', location_type: 'state', parent_location_id: 1 },
    { name: 'Valencia', location_type: 'city', parent_location_id: 35 },
    { name: 'Guacara', location_type: 'town', parent_location_id: 36 },
    { name: 'Aragua', location_type: 'state', parent_location_id: 1 },
    { name: 'Maracay', location_type: 'city', parent_location_id: 38 },
    { name: 'Cagua', location_type: 'town', parent_location_id: 39 },
    { name: 'Guarico', location_type: 'state', parent_location_id: 1 },
    { name: 'San Juan de los Morros', location_type: 'city', parent_location_id: 41 },
    { name: 'Calabozo', location_type: 'town', parent_location_id: 42 },
    { name: 'Bolivar', location_type: 'state', parent_location_id: 1 },
    { name: 'Ciudad Bolivar', location_type: 'city', parent_location_id: 44 },
    { name: 'Upata', location_type: 'town', parent_location_id: 45 },
    { name: 'Monagas', location_type: 'state', parent_location_id: 1 },
    { name: 'Maturin', location_type: 'city', parent_location_id: 47 },
    { name: 'Punta de Mata', location_type: 'town', parent_location_id: 48 }
  ]
)

User.create!(
  [
    {
      email: 'jesusdesk@gmail.com',
      password: '123456',
      password_confirmation: '123456',
      first_name: 'Jesus',
      last_name: 'Diaz',
      dni: 'V27028320',
      gender: 'Male',
      birthdate: '1997-11-26',
      address: 'Los Samanes',
      phone_number: '0414-1234567',
      location_id: 4
    },
    {
      email: 'mgratero@gmail.com',
      password: '123456',
      password_confirmation: '123456',
      first_name: 'Miguel',
      last_name: 'Graterol',
      dni: 'V12345678',
      gender: 'Male',
      birthdate: '1993-6-21',
      address: 'Catia',
      phone_number: '0414-12345674',
      location_id: 4
    }
  ]
)

Brand.create!(
  [
    {
      name: 'Toyota'
    },
    {
      name: 'Ford'
    },
    {
      name: 'Chevrolet'
    }
  ]
)

Model.create!(
  [
    {
      name: 'Corolla',
      brand_id: 1
    },
    {
      name: 'Hilux',
      brand_id: 1
    },
    {
      name: 'Fiesta',
      brand_id: 2
    },
    {
      name: 'Focus',
      brand_id: 2
    },
    {
      name: 'Cruze',
      brand_id: 3
    },
    {
      name: 'Aveo',
      brand_id: 3
    }
  ]
)

user = User.find(2)

gma = Company.new(
  name: 'GMA Desarrollo, C.A',
  dni: '1234567890',
  email: 'mgratero@gmail.com',
  number_of_employees: 1,
  phone_numbers: ['0424-1234589'],
  address: 'Sta Rosa',
  location_id: Location.where(location_type: 'town').first.id,
  user_ids: [user.id]
)

gma.company_charter.attach(
  io: Rails.root.join('spec/fixtures/files/company_charter.pdf').open,
  filename: 'company_charter.pdf',
  content_type: 'application/pdf'
)

gma.company_images.attach(
  [
    {
      io: Rails.root.join('spec/fixtures/files/image.jpg').open,
      filename: 'image.jpg',
      content_type: 'image/jpg'
    }
  ]
)

gma.save

user_company = UserCompany.where(company_id: gma.id, user_id: user.id).first
user_company.update!(roles: ['superadmin'])
