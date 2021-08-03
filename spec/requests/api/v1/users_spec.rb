require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do

  path '/api/v1/users' do

    get('list users') do
      tags 'Users'
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

    post('create user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          name: { type: :string }
        },
        required: %w[email name]
      }
      response(201, 'Created') do
        let(:user) { { email: 'e1@gmail.com', name: 'aaa' } }

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

  path '/api/v1/users/{id}' do
    # You'll want to customize the parameter types...
    parameter name: :id, in: :path, type: :string, description: 'id'

    get('show user') do
      tags 'Users'
      response(200, 'successful') do
        let(:id) { User.create(email: 'e22@mail.com', name: 'e22').id }

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

    patch('update user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          name: { type: :string }
        },
        required: %w[email name]
      }

      response(200, 'successful') do
        let(:id) { User.create(email: 'e223@mail.com', name: 'e223').id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        let(:user) { { email: 'e223@mail.com', name: 'e223' } }

        run_test!
      end
    end

    put('update user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          name: { type: :string }
        },
        required: %w[email name]
      }

      response(200, 'successful') do
        let(:id) { User.create(email: 'e223@mail.com', name: 'e223').id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        let(:user) { { email: 'e223@mail.com', name: 'e223' } }

        run_test!
      end
    end

    delete('delete user') do
      tags 'Users'
      response(204, 'No Content') do
        let(:id) { User.create(email: 'e224@mail.com', name: 'e224').id }
        run_test!
      end
    end
  end
end
