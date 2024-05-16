################################################################
#DO NOT EDIT -- DO NOT EDIT -- DO NOT EDIT -- DO NOT EDIT -- DO
################################################################
p1 = Pricing.create(category: "Dias úteis")
p2 = Pricing.create(category: "Finais de semana e feriados")

pix = PaymentMethod.create(method: "PIX")
cc = PaymentMethod.create(method: "Cartão de Crédito")
cd = PaymentMethod.create(method: "Cartão de Débito")
dep = PaymentMethod.create(method: "Depósito Bancário")
################################################################
# ==============================================================
################################################################


################################################################
#DUMMY DATA - DUMMY DATA - DUMMY DATA - DUMMY DATA - DUMMY DATA -
################################################################
company_a = Company.create!(
  buffet_name: "Buffet Jaquin",
  company_registration_number: "74.391.888/0001-77",
  email: "jaquin@gmail.com",
  password: "safestpasswordever"
)
buffet_a = Buffet.new(
  email: "buffetjaquin@gmail.com",
  company_name: "Jaquin comidas",
  phone_number: "112345556",
  zip_code: "04941-020",
  adress: "Rua Seringal do Rio Verde",
  neighborhood: "Rua Seringal do Rio Verde",
  city: "São Paulo",
  state_code: "SP",
  description: "O Buffet do Jaquin é uma experiência gastronômica única, trazendo o melhor da culinária brasileira com
    um toque de criatividade e inovação. Com um cardápio diversificado e saboroso, nossos pratos são cuidadosamente
    preparados com ingredientes frescos e selecionados, garantindo uma explosão de sabores em cada mordida.
    Nossos serviços vão além da comida deliciosa. Oferecemos um ambiente aconchegante e acolhedor, perfeito para eventos
    de todos os tipos, desde festas de casamento e aniversários até eventos corporativos e confraternizações.
    Além disso, o Buffet do Jaquin se destaca pelo atendimento personalizado e pela atenção aos detalhes, garantindo
    que cada evento seja único e memorável para todos os nossos clientes.
    Venha nos conhecer e descubra por que somos a escolha ideal para tornar o seu evento ainda mais especial!",
  company_id: company_a.id,
)
buffet_a.cover.attach(io: File.open('./app/assets/images/jaquin.jpg'), filename: 'jaquin.jpg', content_type: 'image/jpg')
buffet_a.save
BuffetPaymentMethod.create!(buffet_id: buffet_a.id, payment_method_id: pix.id)
BuffetPaymentMethod.create!(buffet_id: buffet_a.id, payment_method_id: cc.id)
BuffetPaymentMethod.create!(buffet_id: buffet_a.id, payment_method_id: cd.id)
BuffetPaymentMethod.create!(buffet_id: buffet_a.id, payment_method_id: dep.id)

event_a = Event.new(
  name: "Jantar elegante",
  description: "Prepare-se para uma noite de elegância e sofisticação no evento exclusivo do Buffet do Jaquin.
    Em um ambiente luxuoso e refinado, você será recebido com o melhor da gastronomia gourmet e um serviço impecável.
    O jantar começa com uma seleção de entradas requintadas, cuidadosamente elaboradas para despertar seu paladar. Em
    seguida, você será convidado a saborear pratos principais preparados por nossos talentosos chefs, que combinam
    ingredientes frescos e técnicas culinárias de alta qualidade para criar experiências gastronômicas memoráveis.
    Cada detalhe do evento é planejado com atenção aos mínimos detalhes, desde a disposição dos talheres até a decoração
    impecável do ambiente. A música ao vivo cria uma atmosfera envolvente, enquanto você desfruta de conversas animadas
    com outros convidados em uma noite inesquecível. Para completar a experiência, uma seleção de sobremesas finas é
    servida, acompanhada de vinhos selecionados que complementam perfeitamente cada prato. Este evento no Buffet do
    Jaquin é uma celebração da boa comida, da boa companhia e do bom gosto. Junte-se a nós para uma noite de indulgência
    e elegância que certamente deixará uma impressão duradoura.",
  min_quorum: 5,
  max_quorum: 16,
  standard_duration: 240,
  menu: "Pratos Principais:
    Filé de salmão ao molho de manteiga de ervas frescas, acompanhado de risoto de limão siciliano.
    Medalhões de filé mignon grelhados, servidos com molho de vinho tinto e risoto de cogumelos selvagens.
    Confit de pato com laranja caramelizada, purê de batata-doce e molho de laranja.
    Sobremesas:
    Mousse de chocolate belga com calda de frutas vermelhas.
    Tiramisu clássico italiano, polvilhado com cacau em pó.
    Crème brûlée de baunilha bourbon, com casquinha crocante de açúcar caramelizado.
    Bebidas:
    Seleção de vinhos tintos e brancos premium, cuidadosamente escolhidos para harmonizar com os pratos.
    Águas aromatizadas com frutas frescas.
    Café e chás gourmet.
    Este menu foi criado para proporcionar uma experiência culinária refinada e inesquecível. Aprecie cada prato
    com todos os sentidos e desfrute de uma noite de indulgência e elegância no Buffet do Jaquin.",
  serve_alcohol: true,
  handle_decoration: true,
  valet_service: false,
  flexible_location: true,
  buffet_id: buffet_a.id,
)
event_a.event_cover.attach(io: File.open('./app/assets/images/fancy_dinner.jpg'), filename: 'fancy_dinner.jpg', content_type: 'image/jpg')
event_a.save
event_b = Event.new(
  name: "Festa de 15 anos",
  description: "Bem-vindos a uma noite de celebração e encanto no renomado Buffet do Chef Jaquin, onde cada detalhe é
    meticulosamente preparado para proporcionar uma experiência inesquecível. Nossa equipe talentosa está dedicada a
    transformar o sonho da sua debutante em realidade, oferecendo um evento repleto de sofisticação, sabor e diversão.
    Ambiente Exclusivo:
    O Buffet do Chef Jaquin é conhecido por sua atmosfera elegante e acolhedora, que combina o charme clássico com
    toques modernos. O salão de festas é decorado com requinte, apresentando uma decoração luxuosa e contemporânea,
    com detalhes que refletem o estilo único do renomado chef. Cada elemento, desde os arranjos de flores até a
    iluminação ambiente, é cuidadosamente selecionado para criar uma atmosfera sofisticada e convidativa.
    Culinária de Alta Gastronomia:
    A gastronomia é o destaque da noite no Buffet do Chef Jaquin, onde os paladares mais exigentes são surpreendidos
    com uma experiência culinária verdadeiramente excepcional. O menu é elaborado pelo próprio Chef Jaquin, que
    combina técnicas clássicas da culinária francesa com ingredientes frescos e sazonais para criar pratos memoráveis
    e deliciosos. De entradas sofisticadas a pratos principais refinados e sobremesas irresistíveis, cada mordida é
    uma experiência sensorial única e surpreendente.
    Entretenimento de Primeira Classe:
    A diversão está garantida com o entretenimento de primeira classe oferecido no Buffet do Chef Jaquin.
    Uma pista de dança espaçosa convida os convidados a dançar ao som de músicas animadas e envolventes,
    enquanto artistas talentosos e performances ao vivo adicionam um toque de glamour e sofisticação à festa.
    Além disso, uma variedade de atividades interativas e entretenimento personalizado é oferecida para garantir
    que todos se divirtam ao máximo durante a celebração.
    Momentos Especiais:
    A debutante é homenageada com uma cerimônia emocionante e uma dança especial, marcando o início de uma nova
    fase em sua vida. Momentos como esses são cuidadosamente planejados e capturados por uma equipe de fotógrafos
    profissionais, garantindo que cada instante seja eternizado de forma bela e memorável.
    Lembranças Personalizadas:
    Ao final da festa, os convidados recebem lembranças personalizadas como uma recordação desse dia especial.
    Desde álbuns de fotos customizados até brindes temáticos exclusivos, cada lembrança é projetada para refletir
    o espírito e a essência da festa de 15 anos no Buffet do Chef Jaquin.
    No Buffet do Chef Jaquin, estamos comprometidos em criar eventos excepcionais que encantam os sentidos e
    criam memórias duradouras. Deixe-nos fazer parte do seu momento especial e transformar sua festa de 15
    anos em uma experiência verdadeiramente inesquecível.",
  min_quorum: 20,
  max_quorum: 100,
  standard_duration: 360,
  menu: "Pratos Principais:
    Filé de salmão ao molho de manteiga de ervas frescas, acompanhado de risoto de limão siciliano.
    Medalhões de filé mignon grelhados, servidos com molho de vinho tinto e risoto de cogumelos selvagens.
    Confit de pato com laranja caramelizada, purê de batata-doce e molho de laranja.
    Sobremesas:
    Mousse de chocolate belga com calda de frutas vermelhas.
    Tiramisu clássico italiano, polvilhado com cacau em pó.
    Crème brûlée de baunilha bourbon, com casquinha crocante de açúcar caramelizado.
    Bebidas:
    Seleção de vinhos tintos e brancos premium, cuidadosamente escolhidos para harmonizar com os pratos.
    Águas aromatizadas com frutas frescas.
    Café e chás gourmet.
    Este menu foi criado para proporcionar uma experiência culinária refinada e inesquecível. Aprecie cada prato
    com todos os sentidos e desfrute de uma noite de indulgência e elegância no Buffet do Jaquin.",
  serve_alcohol: true,
  handle_decoration: true,
  valet_service: true,
  flexible_location: true,
  buffet_id: buffet_a.id,
)
event_b.event_cover.attach(io: File.open('./app/assets/images/15y_party.jpeg'), filename: '15y_party.jpeg', content_type: 'image/jpeg')
event_b.save
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
EventPricing.create!(
  event_id: event_b.id,
  pricing_id: p1.id,
  base_price: 4000,
  extra_person_fee: 300,
  extra_hour_fee: 500
)
ep2_b = EventPricing.create!(
  event_id: event_b.id,
  pricing_id: p2.id,
  base_price: 7000,
  extra_person_fee: 400,
  extra_hour_fee: 900
)
client_a = Client.create!(
  full_name: "Matheus Bellucio",
  social_security_number: "455.069.420-36",
  email: "matheus@gmail.com",
  password: "safestpasswordever"
)
client_b = Client.create!(
  full_name: "Julia kanzaki",
  social_security_number: "967.140.620-36",
  email: "julia@gmail.com",
  password: "safestpasswordever"
)
client_c = Client.create!(
  full_name: "Rafael Salgado",
  social_security_number: "487.468.040-21",
  email: "rafa@gmail.com",
  password: "safestpasswordever"
)
Order.create!(
  company_id: company_a.id,
  client_id: client_a.id,
  event_pricing_id: ep1_a.id,
  booking_date: 2.week.from_now,
  predicted_guests: 10,
  event_details: "Jantar de aniversário",
  event_adress: "Rua Luís Maria Soares 10",
  status: :pending
)
order_client_b = Order.create!(
  company_id: company_a.id,
  client_id: client_b.id,
  event_pricing_id: ep2_a.id,
  booking_date: 2.week.from_now,
  predicted_guests: 12,
  event_details: "Jantar de casamento",
  event_adress: "Rua Alasca 102",
  status: :awaiting
)
Budget.create!(
  order_id: order_client_b.id,
  payment_method_id: pix.id,
  proposal_deadline: 1.week.from_now,
  additional_cost: 2000
)
Order.create!(
  company_id: company_a.id,
  client_id: client_c.id,
  event_pricing_id: ep2_a.id,
  booking_date: 3.month.from_now,
  predicted_guests: 6,
  event_details: "Jantar de namoro",
  event_adress: "Rua José do Rosário",
  status: :canceled
)
order_client_c = Order.create!(
  company_id: company_a.id,
  client_id: client_c.id,
  event_pricing_id: ep2_b.id,
  booking_date: 2.week.from_now,
  predicted_guests: 98,
  event_details: "Festa de 15 anos",
  event_adress: "Rua Henrique Liberti",
  status: :confirmed
)
Budget.create!(
  order_id: order_client_c.id,
  payment_method_id: cc.id,
  proposal_deadline: 3.week.from_now,
  additional_cost: 1000
)

company_a.messages.create!(
  content: "Olá, o número de convidados será este mesmo, 98?",
  order_id: order_client_c.id,
  user_id: company_a.id
)
client_c.messages.create!(
  content: "Sim, 98, por qual motivo?",
  order_id: order_client_c.id,
  user_id: client_c.id
)
company_a.messages.create!(
  content: "Pois não servirmos mais de 100 pessoas, nossa equipe trabalha com no máximo 100, como descrito no evento.",
  order_id: order_client_c.id,
  user_id: company_a.id
)
client_c.messages.create!(
  content: "Sim, 98, por qual motivo?",
  order_id: order_client_c.id,
  user_id: client_c.id
)
company_a.messages.create!(
  content: "Pois como está perto do limite máximo a gente costuma deixar claro que não aceitamos que passe de 100.",
  order_id: order_client_c.id,
  user_id: company_a.id
)
client_c.messages.create!(
  content: "Mas se por um acaso passar 1 ou 2 pessoas do limite tem problema? eu pago a mais!",
  order_id: order_client_c.id,
  user_id: client_c.id
)
company_a.messages.create!(
  content: "Reiteramos que não aceitamos que se passe de 100, norma da empresa. Espero que compreenda.",
  order_id: order_client_c.id,
  user_id: company_a.id
)
client_c.messages.create!(
  content: "Ok, tomarei cuidado. Obrigado!",
  order_id: order_client_c.id,
  user_id: client_c.id
)

company_a.messages.create!(
  content: "Oi, te enviamos a proposta do orçamento e vimos que ainda não aceitou, algum problema?",
  order_id: order_client_b.id,
  user_id: company_a.id
)
client_b.messages.create!(
  content: "Ainda estou analizando se terei condições...",
  order_id: order_client_b.id,
  user_id: client_b.id
)
company_a.messages.create!(
  content: "Ok, qualquer dúvidas este chat está aberto hein!",
  order_id: order_client_b.id,
  user_id: company_a.id
)

company_b = Company.create!(
  buffet_name: "Delícias do Paladar",
  company_registration_number: "62.702.260/0001-66",
  email: "delicias@gmail.com",
  password: "safestpasswordever"
)
buffet_b = Buffet.create!(
  email: "deliciasbuffet@gmail.com",
  company_name: "Celestial Catering Ltda.",
  phone_number: "112345556",
  zip_code: "03324-060",
  adress: "Rua Otelo Rizzo",
  neighborhood: "Vila Gomes Cardim",
  city: "São Paulo",
  state_code: "SP",
  description: "Buffet bem legal",
  company_id: company_b.id,
)
buffet_b.cover.attach(io: File.open('./app/assets/images/test.jpg'), filename: 'test.jpg', content_type: 'image/jpg')
buffet_b.save
BuffetPaymentMethod.create!(buffet_id: buffet_b.id, payment_method_id: pix.id)

company_c = Company.create!(
  buffet_name: "Gastronomia Real",
  company_registration_number: "43.933.008/0001-13",
  email: "greal@gmail.com",
  password: "safestpasswordever"
)
buffet_c = Buffet.new(
  email: "grealbuffet@gmail.com",
  company_name: "Elite Gastronômica Empreendimentos Ltda.",
  phone_number: "112345556",
  zip_code: "05592-140",
  adress: "Praça Isai Leiner",
  neighborhood: "Jardim Bonfiglioli",
  city: "São Paulo",
  state_code: "SP",
  description: "Buffet bem legal",
  company_id: company_c.id,
)
buffet_c.cover.attach(io: File.open('./app/assets/images/test.jpg'), filename: 'test.jpg', content_type: 'image/jpg')
buffet_c.save
BuffetPaymentMethod.create!(buffet_id: buffet_c.id, payment_method_id: pix.id)

company_d = Company.create!(
  buffet_name: "Sabor Divino",
  company_registration_number: "58.613.145/0001-48",
  email: "sdivino@gmail.com",
  password: "safestpasswordever"
)
buffet_d = Buffet.new(
  email: "sdivinobuffet@gmail.com",
  company_name: "Sabores Nobres S.A.",
  phone_number: "112345556",
  zip_code: "05420-002",
  adress: "Avenida Pedroso de Morais",
  neighborhood: "Pinheiros",
  city: "São Paulo",
  state_code: "SP",
  description: "Buffet bem legal",
  company_id: company_d.id,
)
buffet_d.cover.attach(io: File.open('./app/assets/images/test.jpg'), filename: 'test.jpg', content_type: 'image/jpg')
buffet_d.save
BuffetPaymentMethod.create!(buffet_id: buffet_d.id, payment_method_id: pix.id)
################################################################
# ==============================================================
################################################################
