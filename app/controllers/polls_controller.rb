class PollsController < ApplicationController
  def new
    @poll = Poll.new
    @group_id = params[:group_id] || 1
  end

  def create
    @poll = Poll.new(params[:poll])


    if @poll.save
      flash[:success] = "New poll successfully created with group id: #{params[:poll][:group_id]}!"

      redirect_to @poll
    else
      flash[:failure] = "Could not save poll"
      render 'new'
    end
  end

  def show
    @poll = Poll.find(params[:id])
  end
end
