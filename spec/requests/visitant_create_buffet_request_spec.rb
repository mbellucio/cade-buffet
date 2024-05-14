require 'rails_helper'

describe 'Visitant creates buffet' do
  it 'but fails because is not authenticated' do
    #arrange
    #act
    post "/buffets", :params => { :widget => {
      :company_name => "some name",
      :phone_number => "114252671",
      :zip_code => "20561-116",
      :adress => "some street 10",
      :neighborhood => "some place",
      :city => "some city",
      :state_code => "NY",
      :description => "very nice",
      :email => "somemail@gmail.com",
    }}
    #assert
    expect(response).to redirect_to new_company_session_path
  end
end
