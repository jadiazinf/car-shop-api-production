town = Location.where(location_type: 'town').first

User.create!(
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
    location_id: town.id
  }
)

miguel = User.create!(
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
    location_id: town.id
  }
)

gma = Company.new(
  name: 'GMA Desarrollo, C.A',
  dni: '1234567890',
  email: 'mgratero@gmail.com',
  number_of_employees: 1,
  phone_numbers: ['0424-1234589'],
  address: 'Sta Rosa',
  location_id: town.id
)

gma.user_companies.build(user_id: miguel.id, roles: ['superadmin'])

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
