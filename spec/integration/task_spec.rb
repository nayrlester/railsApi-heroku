# spec/integration/task_spec.rb
require 'swagger_helper'

describe 'Tasks API' do

  path '/tasks' do

    post 'Create new tasks' do
      tags 'Tasks'
      security [Bearer: {}]
      consumes 'application/json', 'application/xml'
      parameter name: :task_name, name: :description, in: :body, schema: {
        type: :object,
        properties: {
          task_name: { type: :string },
          description: { type: :string }
        },
        required: [ 'task_name', 'description' ]
      }

      response '201', 'New tasks created' do
        let(:"Authorization") { "Bearer #{token_for(user)}" }
        run_test!
      end

      response '422', 'Failed adding new tasks' do
        run_test!
      end

      response '500', 'Internal Server Error' do
        run_test!
      end
    end
  end

  path '/tasks/{id}' do

    get 'Retrieves a tasks' do
      tags 'Tasks'
      produces 'application/json', 'application/xml'
      security [Bearer: {}]
      parameter name: :id, :in => :path, :type => :integer

      response '200', 'Tasks found' do
        schema type: :object,
          properties: {
            id: {type: :integer},
            task_name: {type: :string},
            description: {type: :string},
          },

        required: ['id']
        let(:"Authorization") { "Bearer #{token_for(user)}" }
        let(:id) { tasks.id }
        run_test!
      end

      response '404', 'invalid request' do
        let(:id) { 'invalid' }
        run_test! 
      end

    end
  end

  path '/tasks/{id}' do

    delete 'Delete tasks' do
      tags 'Tasks'
      consumes 'application/json', 'application/xml'
      produces 'application/json', 'application/xml'
      security [Bearer: {}]
      parameter name: :id, :in => :path, :type => :integer

      response '204', 'Tasks deleted' do
        let(:"Authorization") { "Bearer #{token_for(user)}" }
        run_test!
      end

      response '422', 'Task not Found' do
        let(:id) { 'invalid' }
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end
  end

  path '/tasks/{id}' do

    put 'Update tasks' do
      tags 'Tasks'
      produces 'application/json', 'application/xml'
      security [Bearer: {}]
      parameter name: :id, :in => :path, :type => :integer
      parameter name: :task_name, name: :description, in: :body, schema: {
        type: :object,
        properties: {
          task_name: { type: :string },
          description: { type: :string }
        },
        required: [ 'task_name', 'description' ]
      }

      response '200', 'Tasks update' do
        let(:"Authorization") { "Bearer #{token_for(user)}" }
        run_test!
      end

      response '422', 'Task not Found' do
        let(:id) { 'invalid id supplied' }
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end
  end

end