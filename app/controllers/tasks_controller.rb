class TasksController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_task, except: %i[create index]

  # GET /tasks
  def index
    @tasks = Task.all

    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task, status: :ok
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created
    else
       render json: { errors: @task.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @tasks
    else
      render json: @tasks.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_task
      @task = Task.find_by_id(params[:id])
      rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Task not found' }, status: :not_found
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.permit(
         :task_name, :description 
      )
    end
end
