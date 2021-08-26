class TasksController < ApplicationController
    #Any actions involving tasks requires login due to private information involved.
    before_action :authenticate_user!

    def index
        @tasks = Task.all
    end

    def show
        @task = Task.find(params[:id])
        #Make a database query to list quotes, newest first.
        @quotes = Quote.where(task_id: @task).order(created_at: :desc)
    end

    def edit
        @task = Task.find(params[:id])
    end

    def new
        @task = Task.new
    end

    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
            redirect_to task_path(@task), notice: "Task successfully updated."
        else
            render :edit
        end
    end

    def create
        #Create the task with the user_id of current user.
        @task = Task.create(task_params.merge(user_id: current_user.id))
        if @task.save
            redirect_to @task, notice: "Success."
        else
            render :new
        end
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        redirect_to tasks_path, notice: "Task successfully deleted."
    end

    private
    #Permit task parameters to come through this private method. 
        def task_params
            params.require(:task).permit(:address, :description, :latitude, :longitude)
        end
end
