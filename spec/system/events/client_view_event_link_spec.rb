require 'rails_helper'

describe 'Client view event link' do
  it '' do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    buffet = Buffet.create!(
      email: "somecompany@gmail.com",
      company_name: "some company",
      phone_number: "112345556",
      zip_code: "123231231",
      adress: "some street 1000",
      neighborhood: "some district",
      city: "some city",
      state_code: "CA",
      description: "A nice buffet",
      company_id: company.id
    )
    event = Event.create!(
      name: "Festa Infantil",
      description: "muito legal!",
      min_quorum: 10,
      max_quorum: 50,
      standard_duration: 240,
      menu: "Cachorro quente e batata frita",
      serve_alcohol: false,
      handle_decoration: true,
      valet_service: false,
      flexible_location: true,
      buffet_id: buffet.id,
      event_cover: fixture_file_upload(Rails.root.join('spec', 'support', 'buffet_img.jpg'))
    )
    client = Client.create!(
      full_name: "Matheus Bellucio",
      social_security_number: "455.069.420-36",
      email: "matheus@gmail.com",
      password: "safestpasswordever"
    )
    #act
    login_as(client, scope:client)
    visit buffet_path(buffet.id)
    #assert
    within("div#event-#{event.id}") do
      expect(page).to have_link "Festa Infantil"
      expect(page).to have_css('img[src*="buffet_img.jpg"]')
    end
  end
end
