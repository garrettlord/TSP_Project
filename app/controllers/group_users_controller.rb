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
    @group_user = GroupUser.new(group_id: Group.find_by_name(params[:group_name]).id,
        user_id: User.find_by_name(params[:user_name]).id)
    if @group_user.save
      flash[:success] = "New association created!"
      redirect_to @group_user
    else
      render 'new'
    end
  end

  def multiple_create
    success = true
    unless params[:groups].nil? # no errors
      params[:groups].each do |group|
        group_user = GroupUser.new(group_id: group, user_id: params[:user_id], admin: false)
        unless group_user.save
          success = false
        end
      end
      if success
        flash[:success] = "Groups added"
      else
        flash[:error] = "Could not add all groups"
      end
    else
      flash[:error] = "Could not add any groups"
    end
    redirect_to User.find(params[:user_id])
  end

  def destroy
    @group_user = GroupUser.find(params[:id])
    @group_user.destroy

    redirect_to group_users_url
  end

  def multiple_destroy
    success = true
    unless params[:groups].nil? # no errors
      params[:groups].each do |group|
        group_user = GroupUser.find(:first, :conditions => { group_id: group, user_id: params[:user_id] })
        if group_user.nil?
          success = false
        else
          group_user.destroy
        end
      end
      if success
        flash[:success] = "Groups removed"
      else
        flash[:error] = "Could not remove all groups"
      end
    else
      flash[:error] = "Could not remove any groups"
    end
    redirect_to User.find(params[:user_id])
  end
end
