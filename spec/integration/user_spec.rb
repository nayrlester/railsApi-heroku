# spec/integration/user_spec.rb
require 'swagger_helper'

describe 'Users API' do

  path '/users' do

    post 'Register new users' do
      tags 'Users'
      consumes 'application/json', 'application/xml'
      parameter name: :email,name: :password,name: :first_name,name: :last_name, name: :username, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          username: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'first_name', 'last_name', 'username', 'email', 'password' ]
      }

      response '201', 'user created' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  path '/users/{id}' do

    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json', 'application/xml'
      security [Bearer: {}]
      parameter name: :id, :in => :path, :type => :string

      response '200', 'User found' do
        schema type: :object,
        properties: {
          id: {type: :integer},
          first_name: { type: :string },
          last_name: { type: :string },
          username: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
        let(:"Authorization") { "Bearer #{token_for(user)}" }
        run_test!
      end
      response '422', 'invalid request' do
        run_test!
      end
    end
  end


  path '/auth/login' do

    post 'Auth users login' do
      tags 'Auth'
      consumes 'application/json', 'application/xml'
      produces 'application/json', 'application/xml'
      parameter name: :email, name: :password, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }

      response '201', 'User login successfully' do
        run_test!
      end

      response '422', 'invalid email/password' do
        run_test!
      end
    end
  end

end