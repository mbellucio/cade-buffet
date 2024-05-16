require 'rails_helper'

describe 'Visitant execute searches' do
  it 'by Buffet name' do
    #arrange
    company = Company.create!(
      buffet_name: "some Buffet",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    Buffet.create!(
      email: "someemail@gmail.com",
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
    #act
    visit root_path
    within("nav") do
      fill_in "Procurar...", with: "some"
      click_on "Procurar"
    end
    #assert
    expect(page).to have_content "some Buffet"
    expect(page).to have_content "some city"
    expect(page).to have_content "CA"
  end

  it "with multiple buffets in alphabetical order" do
    #arrange
    company = Company.create!(
      buffet_name: "Buffet some",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    company2 = Company.create!(
      buffet_name: "some Buffet 2",
      company_registration_number: "74.391.888/0001-88",
      email: "company2@gmail.com",
      password: "safestpasswordever"
    )
    Buffet.create!(
      email: "someemail@gmail.com",
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
    Buffet.create!(
      email: "someemail2@gmail.com",
      company_name: "some company2",
      phone_number: "1123213213",
      zip_code: "124534535",
      adress: "some street 2000",
      neighborhood: "some district 2",
      city: "some city 2",
      state_code: "NY",
      description: "A nice buffet 2",
      company_id: company2.id
    )
    #act
    visit root_path
    within("nav") do
      fill_in "Procurar...", with: "some"
      click_on "Procurar"
    end
    #assert
    within("div#buffet-0") do
      expect(page).to have_content "Buffet some"
    end
    within("div#buffet-1") do
      expect(page).to have_content "some Buffet 2"
    end
  end

  it "with events in alphabetical order" do
    #arrange
    company = Company.create!(
      buffet_name: "New York",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    company2 = Company.create!(
      buffet_name: "Alabama",
      company_registration_number: "74.391.888/0001-88",
      email: "company2@gmail.com",
      password: "safestpasswordever"
    )
    company3 = Company.create!(
      buffet_name: "Seattle",
      company_registration_number: "74.391.888/0001-90",
      email: "company3@gmail.com",
      password: "safestpasswordever"
    )
    buffet = Buffet.create!(
      email: "someemail@gmail.com",
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
    buffet2 = Buffet.create!(
      email: "someemail2@gmail.com",
      company_name: "some company2",
      phone_number: "1123213213",
      zip_code: "124534535",
      adress: "some street 2000",
      neighborhood: "some district 2",
      city: "some city 2",
      state_code: "NY",
      description: "A nice buffet 2",
      company_id: company2.id
    )
    buffet3 = Buffet.create!(
      email: "someemail3@gmail.com",
      company_name: "some company2",
      phone_number: "1123213213",
      zip_code: "124534535",
      adress: "some street 2000",
      neighborhood: "some district 2",
      city: "some city 2",
      state_code: "NY",
      description: "A nice buffet 2",
      company_id: company3.id
    )
    Event.create!(
      name: "Barbecue",
      description: "muito legal!",
      min_quorum: 10,
      max_quorum: 50,
      standard_duration: 240,
      menu: "Cachorro quente e batata frita",
      serve_alcohol: true,
      handle_decoration: true,
      valet_service: false,
      flexible_location: true,
      buffet_id: buffet.id
    )
    Event.create!(
      name: "Barbecue",
      description: "muito legal!",
      min_quorum: 10,
      max_quorum: 50,
      standard_duration: 240,
      menu: "Cachorro quente e batata frita",
      serve_alcohol: true,
      handle_decoration: true,
      valet_service: false,
      flexible_location: true,
      buffet_id: buffet2.id
    )
    Event.create!(
      name: "Barbecue",
      description: "muito legal!",
      min_quorum: 10,
      max_quorum: 50,
      standard_duration: 240,
      menu: "Cachorro quente e batata frita",
      serve_alcohol: true,
      handle_decoration: true,
      valet_service: false,
      flexible_location: true,
      buffet_id: buffet3.id
    )
    #act
    visit root_path
    within("nav") do
      fill_in "Procurar...", with: "Barbecue"
      click_on "Procurar"
    end
    #assert
    within("div#buffet-0") do
      expect(page).to have_content "Alabama"
    end
    within("div#buffet-1") do
      expect(page).to have_content "New York"
    end
    within("div#buffet-2") do
      expect(page).to have_content "Seattle"
    end
  end

  it "by city name" do
    #arrange
    company = Company.create!(
      buffet_name: "Buffet some",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    company2 = Company.create!(
      buffet_name: "Durangos",
      company_registration_number: "74.391.888/0001-88",
      email: "company2@gmail.com",
      password: "safestpasswordever"
    )
    Buffet.create!(
      email: "someemail@gmail.com",
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
    Buffet.create!(
      email: "someemail2@gmail.com",
      company_name: "some company2",
      phone_number: "1123213213",
      zip_code: "124534535",
      adress: "some street 2000",
      neighborhood: "some district 2",
      city: "New York",
      state_code: "NY",
      description: "A nice buffet 2",
      company_id: company2.id
    )
    #act
    visit root_path
    within("nav") do
      fill_in "Procurar...", with: "New York"
      click_on "Procurar"
    end
    #assert
    within("div#buffet-0") do
      expect(page).to have_content "Durangos"
    end
  end

  it "Search for buffet, view details and return to page with the filtered events" do
    #arrange
    company = Company.create!(
      buffet_name: "Jaquin",
      company_registration_number: "74.391.888/0001-77",
      email: "company@gmail.com",
      password: "safestpasswordever"
    )
    company2 = Company.create!(
      buffet_name: "Attala",
      company_registration_number: "74.391.888/0001-88",
      email: "company2@gmail.com",
      password: "safestpasswordever"
    )
    Buffet.create!(
      email: "someemail@gmail.com",
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
    Buffet.create!(
      email: "someemail2@gmail.com",
      company_name: "some company2",
      phone_number: "1123213213",
      zip_code: "124534535",
      adress: "some street 2000",
      neighborhood: "some district 2",
      city: "New York",
      state_code: "NY",
      description: "A nice buffet 2",
      company_id: company2.id
    )
    #act
    visit root_path
    within("nav") do
      fill_in "Procurar...", with: "Jaquin"
      click_on "Procurar"
    end
    within("div#buffet-0") do
      click_on "Ver detalhes"
    end
    click_on "Voltar"
    #assert
    expect(current_path).to eq "#{root_path}buffets/search"
    expect(page).to have_content "Jaquin"
    expect(page).not_to have_content "Attala"
  end
end
