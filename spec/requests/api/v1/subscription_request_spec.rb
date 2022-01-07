require 'rails_helper'

describe 'subscriptions api' do
  describe 'gets all subscriptions for a customer' do
    it 'gets subscriptions with valid customer id' do
      customer = create(:customer)
      tea = create(:tea)
      create(:subscription, customer_id: customer.id, tea_id: tea.id)

      get "/api/v1/customers/#{customer.id}/subscriptions"

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_a(Hash)
      expect(json[:data].count).to eq(1)
      expect(json[:data][0]).to have_key(:id)
      expect(json[:data][0]).to have_key(:type)
      expect(json[:data][0]).to have_key(:attributes)
      expect(json[:data][0][:attributes]).to have_key(:title)
      expect(json[:data][0][:attributes]).to have_key(:price)
      expect(json[:data][0][:attributes]).to have_key(:status)
      expect(json[:data][0][:attributes]).to have_key(:frequency)
    end

    it 'returns an error with invalid customer id' do
      customer = create(:customer)
      tea = create(:tea)
      create(:subscription, customer_id: customer.id, tea_id: tea.id)

      get "/api/v1/customers/#{customer.id + 1}/subscriptions"

      expect(response).to_not be_successful
      expect(response).to have_http_status 404
    end
  end

  describe 'creating subscription to a tea' do
    it 'subscribes a customer to a tea subscription' do
      customer = create(:customer)
      tea = create(:tea)
      subscription_params = {
        title: "Lovely tea",
        price: 5,
        status: "active",
        frequency: "Monthly",
        customer_id: customer.id,
        tea_id: tea.id
        }

      post "/api/v1/customers/#{customer.id}/subscriptions",
      params: subscription_params

      expect(response).to be_successful
    end
  end

  describe 'canceling a subscription' do
    it 'successfully cancels a customers subscription' do
      customer = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, status: 'active', customer_id: customer.id, tea_id: tea.id)

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}", params: { status: 'cancelled' }

      subscription.reload

      expect(response).to be_successful
      expect(subscription.status).to eq('cancelled')
    end

    it 'returns an error for invalid subscription id' do
      customer = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, status: 'active', customer_id: customer.id, tea_id: tea.id)

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id + 1}", params: { status: 'cancelled' }

      expect(response).to_not be_successful
      expect(response).to have_http_status 404
    end

    it 'returns an error if status is not valid' do
      customer = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, status: 'active', customer_id: customer.id, tea_id: tea.id)

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}", params: { status: 2345 }

      expect(response).to_not be_successful
      expect(response).to have_http_status 400
    end
  end
end
