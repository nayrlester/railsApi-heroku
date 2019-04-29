class Task < ApplicationRecord
  	validates :task_name, :description, presence: true
end
