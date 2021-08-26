class QuotesController < ApplicationController
  #Before the actions, find the appropriate entities and create accessible instance variables.
  before_action :find_task
  before_action :find_quote, only: [:destroy, :edit, :update, :quote_owner]
  before_action :quote_owner, only: [:destroy, :edit, :update]

  def create
    #Create quote record with following parameters.
    @quote = @task.quotes.create(params[:quote].permit(:content, :price, :booking))
    @quote.user_id = current_user.id
    @quote.save

    #If quote is saved, redirect to task page, otherwise try again.
    if @quote.save
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def edit
    #no need to find task as it will already occur from :find_task. Deleted due to DRY.
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

  #Only allow edits if user owns the quote or is an admin.
  def quote_owner
    unless current_user.id == @quote.user_id || current_user.id == @task.user_id
      flash[:alert] = "You are not the owner of this quote or task."
    end
  end
end
