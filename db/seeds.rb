p1 = Pricing.create(category: "Dias úteis")
p2 = Pricing.create(category: "Finais de semana e feriados")

pix = PaymentMethod.create(method: "PIX")
cc = PaymentMethod.create(method: "Cartão de Crédito")
cd = PaymentMethod.create(method: "Cartão de Débito")
dep = PaymentMethod.create(method: "Depósito Bancário")

company_a = Company.create!(
  buffet_name: "some Buffet",
  company_registration_number: "74.391.888/0001-77",
  email: "company@gmail.com",
  password: "safestpasswordever"
)
buffet_a = Buffet.create!(
  email: "somecompany@gmail.com",
  company_name: "some company",
  phone_number: "112345556",
  zip_code: "123231231",
  adress: "some street 1000",
  neighborhood: "some district",
  city: "some city",
  state_code: "CA",
  description: "A nice buffet",
  company_id: company_a.id
)
BuffetPaymentMethod.create!(buffet_id: buffet_a.id, payment_method_id: pix.id)
BuffetPaymentMethod.create!(buffet_id: buffet_a.id, payment_method_id: cc.id)

event_a = Event.create!(
  name: "event1",
  description: "muito legal!",
  min_quorum: 10,
  max_quorum: 50,
  standard_duration: 240,
  menu: "Cachorro quente e batata frita",
  serve_alcohol: true,
  handle_decoration: true,
  valet_service: false,
  flexible_location: true,
  buffet_id: buffet_a.id
)
ep1_a = EventPricing.create!(
  event_id: event_a.id,
  pricing_id: p1.id,
  base_price: 4000,
  extra_person_fee: 300,
  extra_hour_fee: 500
)
ep2_a = EventPricing.create!(
  event_id: event_a.id,
  pricing_id: p2.id,
  base_price: 7000,
  extra_person_fee: 400,
  extra_hour_fee: 900
)

client = Client.create!(
  full_name: "Matheus Bellucio",
  social_security_number: "455.069.420-36",
  email: "matheus@gmail.com",
  password: "safestpasswordever"
)

Order.create!(
  company_id: company_a.id,
  client_id: client.id,
  event_pricing_id: ep1_a.id,
  booking_date: 1.day.from_now,
  predicted_guests: 30,
  event_details: "details",
  event_adress: "some street 10",
  status: :pending
)
Order.create!(
  company_id: company_a.id,
  client_id: client.id,
  event_pricing_id: ep2_a.id,
  booking_date: 1.day.from_now,
  predicted_guests: 40,
  event_details: "details",
  event_adress: "another street 20",
  status: :pending
)
