require 'rails_helper'

RSpec.describe 'Merchants' do
  describe 'REST endpoints' do
    before(:each) do
      create_list(:merchant, 5)
      get '/api/v1/merchants'
    end
    it 'can make successful API call for all Merchants' do
      expect(response).to be_successful
      expect(response.body).to be_a(String)
    end
    it '/merchants sends objects with ID, name, created & updated_at attributes' do
      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants).to be_a(Hash)
      expect(merchants.keys).to eq(%i[data])
      merchants.each do |key, value|
        expect(value).to be_an(Array)
        value.each do |merchant|
          expect(merchant.keys).to eq(%i[id type attributes])
          merchant.each do |k, v|
            if k == :id || k == :type
              expect(v).to be_a(String)
            else
              expect(v).to be_a(Hash)
              expect(v.keys).to eq(%i[id name created_at updated_at])
              v.each do |key1, value1|
                if key1 == :id
                  expect(value1).to be_an(Integer)
                else
                  expect(value1).to be_a(String)
                end
              end
            end
          end
        end
      end
    end
  end
end

RSpec.describe 'Merchant' do
  describe 'REST endpoints' do
    it '/api/v1/merchants/id' do
      merchant = create(:merchant)
      get "/api/v1/merchants/#{merchant.id}"
      expect(response.status).to eq(200)
      result = JSON.parse(response.body, symbolize_names: true)
      expect(result.keys).to eq([:data])
      expect(result[:data]).to be_an(Array)
      expect(result[:data][0].keys).to eq(%i(id type attributes))
      expect(result[:data][0][:attributes].keys).to eq(%i(id name created_at updated_at))
    end
  end
end
