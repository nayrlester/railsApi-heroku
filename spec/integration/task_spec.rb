# spec/integration/user_spec.rb
require 'swagger_helper'

describe 'Tasks API' do

  path '/tasks' do

    post 'Create new tasks' do
      tags 'Tasks'
      consumes 'application/json', 'application/xml'
      parameter name: :task_name, name: :description, in: :body, schema: {
        type: :object,
        properties: {
          task_name: { type: :string },
          description: { type: :text }
        },
        required: [ 'task_name', 'description' ]
      }

      response '201', 'Tasks created' do
        run_test!
      end

      response '422', 'invalid request' do
        run_test!
      end
    end
  end

  path '/tasks' do

    get 'Retrieves a tasks' do
      tags 'Tasks'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'Tasks found' do
        schema type: :array,
        properties: {
          id: {type: :int},
          task_name: { type: :string },
          description: { type: :text }
        },
        required: [ 'id' ]

        run_test!
      end
      response '422', 'invalid request' do
        run_test!
      end
    end
  end

end