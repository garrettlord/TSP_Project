class GroupsController < ApplicationController
def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      flash[:success] = "New group successfully created!"
      redirect_to @group
    else
      render 'new'
    end
  end
end
