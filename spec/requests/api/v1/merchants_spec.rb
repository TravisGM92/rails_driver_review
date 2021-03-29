require 'rails_helper'

RSpec.describe 'Merchants' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end
  describe 'REST endpoints' do
    it 'can get all Merchants' do
      create_list(:merchant, 5)

      response = conn('/api/v1/merchants').get
      expect(response).to be_successful
      require "pry"; binding.pry
    end
  end
end
