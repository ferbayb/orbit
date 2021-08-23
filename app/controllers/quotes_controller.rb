class QuotesController < ApplicationController
    before_action :find_task
    before_action :find_quote, only: [:destroy]

    def create
        @quote = @task.quotes.create(params[:quote].permit(:content, :price, :booking))
        @quote.user_id = current_user.id
        @quote.save

        if @quote.save
            redirect_to task_path(@task)
        else
            render :new
        end
    end

    def update
        if @quote.update(params[:quote].permit(:content, :price, :booking))
            redirect_to task_path(@task), notice: "Success."
        else
            redirect_to task_path(@task), alert: "Quote not saved."
        end
    end

    def destroy
        @quote.destroy
        redirect_to task_path(@task)
    end


    private

        def find_task
            @task = Task.find(params[:task_id])
        end
        
        def find_quote
            @quote = @task.quotes.find(params[:id])
        end
end
