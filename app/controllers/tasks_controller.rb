class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def show
        @task = Task.find(params[:id])
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
        @task = Task.new(task_params)
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
        def task_params
            params.require(:task).permit(:address, :description, :latitude, :longitude)
        end
end
