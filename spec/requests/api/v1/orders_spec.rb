require 'swagger_helper'

RSpec.describe 'api/v1/orders', type: :request do

  path '/api/v1/orders' do

    get('list orders') do
      tags 'Orders'
      parameter name: 'delivery_date', in: :query, type: :string, description: 'YYYY-mm-dd', required: false

      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create order') do
      tags 'Orders'
      consumes 'application/json'
      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          amount: { type: :number },
          user_id: { type: :integer },
          status: { type: :string, enum: ['En preparación', 'En reparto', 'Entregada', 'Recibida'] },
          payment_status: { type: :string, enum: ['Pendiente de pago', 'No pagada', 'Pagada'] }
        },
        required: %w[amount user_id]
      }
      response(201, 'Created') do
        let(:order) { build(:order, user: create(:user)) }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/orders/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show order') do
      tags 'Orders'
      response(200, 'successful') do
        let(:id) { create(:order).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update order') do
      tags 'Orders'
      consumes 'application/json'
      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          amount: { type: :number },
          status: { type: :string, enum: ['En preparación', 'En reparto', 'Entregada', 'Recibida'] },
          payment_status: { type: :string, enum: ['Pendiente de pago', 'No pagada', 'Pagada'] }
        },
        required: %w[amount status payment_status]
      }
      response(200, 'successful') do
        let(:id) { create(:order, amount: 22.3, user: create(:user, email: 'userO1@mail.com', name: 'userO1')).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        let(:order) { { amount: 22.3, user: User.find_by_email('user01@mail.com') } }
        run_test!
      end
    end

    put('update order') do
      tags 'Orders'
      consumes 'application/json'
      parameter name: :order, in: :body, schema: {
        type: :object,
        properties: {
          amount: { type: :number },
          status: { type: :string, enum: ['En preparación', 'En reparto', 'Entregada', 'Recibida'] },
          payment_status: { type: :string, enum: ['Pendiente de pago', 'No pagada', 'Pagada'] }
        },
        required: %w[amount status payment_status]
      }

      response(200, 'successful') do
        let(:id) { create(:order, amount: 22.3, user: create(:user, email: 'userO2@mail.com', name: 'userO1')).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        let(:order) { { amount: 22.3, user: User.find_by_email('user02@mail.com') } }

        run_test!
      end
    end

    delete('delete order') do
      tags 'Orders'
      response(204, 'No Content') do
        let(:id) { create(:order).id }

        run_test!
      end
    end
  end
end
