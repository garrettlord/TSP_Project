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
    group = Group.find_by_name(params[:group_name])
    user = User.find_by_name(params[:user_name])
    if GroupUser.where("group_id = ? AND user_id = ?", group.id, user.id).empty?
      @group_user = GroupUser.new(group_id: group.id,
          user_id: user.id, admin: false)
      if @group_user.save
        flash[:success] = "New association created!"
        redirect_to @group_user
      else
        render 'new'
      end
    else
      flash[:error] = "Association already exists"
      render 'new'
    end
  end

  def multiple_create
    if !params[:groups].nil? # if there are groups in the hash
      params[:groups].each do |group_id|
        if GroupUser.where("group_id = ? AND user_id = ?", group_id.to_i, params[:user_id].to_i).empty?
          group_user = GroupUser.new(group_id: group_id, user_id: params[:user_id], admin: false)
          if group_user.save
            flash[:success] ||= "Groups added:"
            flash[:success] << " #{Group.find(group_id).name},"
          else
            flash[:error] ||= "Groups not added:"
            flash[:error] << " #{Group.find(group_id).name} (could not create),"
          end
        else
          flash[:error] ||= "Groups not added:"
          flash[:error] << " #{Group.find(group_id).name} (already exists),"
        end
      end
    else
      flash[:error] = "No Associations to add"
    end
    unless flash[:success].nil?
      flash[:success] = flash[:success][0..-2]
    end
    unless flash[:error].nil?
      flash[:error] = flash[:error][0..-2]
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
