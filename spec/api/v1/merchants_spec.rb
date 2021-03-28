require 'rails_helper'

RSpec.describe 'Merchants' do
  def conn(uri)
    url = ENV['RAILS_ENGINE_DOMAIN'] + uri
    Faraday.new(url)
  end
  describe 'REST endpoints' do
    it 'can get all Merchants' do
      response = conn('/api/v1/merchants').get

    end
  end
end
