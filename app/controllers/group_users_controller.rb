class GroupUsersController < ApplicationController
  def index
    @group_users = GroupUser.all
  end

  def show
    @group_user = GroupUser.find(params[:id])
  end

  def new
    @group_user = GroupUser.new
  end

  def create
    @group_user = GroupUser.new(group_id: Group.find_by_name(params[:group_name]).id, user_id: User.find_by_name(params[:user_name]).id)
    if @group_user.save
      flash[:success] = "New association created!"
      redirect_to @group_user
    else
      render 'new'
    end
  end
end
