require 'rails_helper'

describe 'visitant creates event' do
  it 'and fails if try to create event' do
    #arrange

    #act
    post "/events", :params => {:event => {
      :name => "some name",
      :description => "very nice",
      :min_quorum => 10,
      :max_quorum => 20,
      :standard_duration => 120,
      :menu => "food",
      :serve_alcohol => true,
      :handle_decoration => true,
      :valet_service => false,
      :flexible_location => false,
    }}
    #assert
    expect(response).to redirect_to new_company_session_path
  end
end
