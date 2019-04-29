# spec/integration/user_spec.rb
require 'swagger_helper'

describe 'Tasks API' do

  path '/tasks' do

    post 'Create new tasks' do
      tags 'Tasks'
      consumes 'application/json', 'application/xml'
      parameter name: :task_name, name: :description, in: :body, schema: {
        type: :array,
        properties: {
          task_name: { type: :string },
          description: { type: :string }
        },
        required: [ 'task_name', 'description' ]
      }

      response '200', 'New tasks created' do
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
      parameter name: :id, :in => :path, :type => :integer

      response '200', 'Tasks found' do
        schema type: :object,
        properties: {
          id: {type: :integer},
          task_name: { type: :string },
          description: { type: :string }
        },
        required: [ 'id' ]

        run_test!
      end
      response '422', 'invalid request' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end

    end
  end

  path '/tasks/{id}' do

    delete 'Delete tasks' do
      tags 'Tasks'
      consumes 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :integer

      response '200', 'Tasks deleted' do
        schema type: :array,
        properties: {
          id: {type: :integer},
          task_name: { type: :string },
          description: { type: :string }
        }
        run_test!
      end

      response '422', 'Task not Found' do
        run_test!
      end
      response '500', 'Internal Server Error' do
        run_test!
      end
    end
  end

end