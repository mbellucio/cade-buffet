# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Pricing.create(category: "Dias úteis")
pricing = Pricing.create(category: "Finais de semana e feriados")

company = Company.create!(
  buffet_name: "Buffet TreinaDev12",
  company_registration_number: "74.391.888/0001-77",
  email: "campuscode@gmail.com",
  password: "safestpasswordever"
)
buffet = Buffet.create!(
  email: "treinadev12@gmail.com",
  payment_method: "pix, cc",
  company_name: "Campus Code",
  phone_number: "(93) 98321-8045",
  zip_code: "04477-480",
  adress: "Rua Fernando",
  neighborhood: "Sete Praias",
  city: "São Paulo",
  state_code: "SP",
  description: "O Buffet TreinaDev12 oferece uma experiência gastronômica única, com uma variedade de opções deliciosas para satisfazer todos os paladares. Com um nome tão especial, você pode esperar uma combinação de pratos cuidadosamente elaborados e um serviço excepcional para tornar qualquer evento inesquecível. Seja para uma festa de casamento, um evento corporativo ou uma reunião especial, o Buffet TreinaDev12 está pronto para oferecer uma experiência gastronômica memorável para você e seus convidados.",
  company_id: company.id
)
event = Event.create!(
  name: "Churrasco",
  description: "Churrasco clássico: Picanha, cerveja e pagode.",
  min_quorum: 10,
  max_quorum: 50,
  standard_duration: 240,
  menu: "Picanha, fraldinha, maminha, linguiça, pão de alho, cupim no bafo, choripam, etc.",
  serve_alcohol: true,
  handle_decoration: false,
  valet_service: false,
  flexible_location: true,
  buffet_id: buffet.id
)
event_pricing = EventPricing.create!(
  event_id: event.id,
  pricing_id: pricing.id,
  base_price: 1000,
  extra_person_fee: 120,
  extra_hour_fee: 150
)
