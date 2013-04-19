class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    if signed_in?
      @group = Group.find(params[:id])
      @admins = @group.admins
      @users = @group.users
      @allusers = User.all

      

      @polls = Poll.where("group_id = ?", @group.id)

      messages = GroupMessage.where("group_id = ?", @group.id)
      @message = ""
      messages.each do |msg|
        msggroup = Group.find(msg.group_id)
        msguser = User.find(msg.user_id)
        unless msggroup.nil? or msguser.nil?
          @message << "#{msggroup.name}: #{msguser.name} - #{msg.message}\n"
        end
      end
    else
      flash[:error] = "You must be signed in to view this page"
      redirect_to signin_url
    end
  end

  def new
    if signed_in?
      @group = Group.new
      @users = User.all
    else
      flash[:error] = "You must be signed in to view this page"
      redirect_to signin_url
    end
  end

  def create
    if signed_in?
      @group = Group.new(params[:group])

      if @group.save
        flash[:success] = "New group successfully created!"

        group_user = GroupUser.new(group_id: @group.id, user_id: current_user.id, admin: true)
        unless group_user.save
          flash[:failure] = "Could not add you as an admin of the new group"
        end

        users = User.all
        users.each do |user|
          if params["#{user.name}"]
            group_user = GroupUser.new(group_id: @group.id, user_id: user.id)
            unless group_user.save
              flash[:failure] = "Could not create the associations checked"
            end
          end
        end

        redirect_to @group
      else
        flash[:failure] = "Could not save group"
        render 'new'
      end
    else
      flash[:error] = "You must be signed in to view this page"
      redirect_to signin_url
    end
  end

  # GET /groups/1/edit
  def edit
    unless signed_in?
      flash[:error] = "You must be signed in to view this page"
      redirect_to signin_url
    end

    @group = Group.find(params[:id])
    unless is_admin? @group.id
      flash[:error] = "You must be the group admin to edit it"
      redirect_to groups_url
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    if signed_in?
      @group = Group.find(params[:id])

      unless is_admin? @group.id
        flash[:error] = "You must be the group admin to edit it"
        redirect_to groups_url
      end

      respond_to do |format|
        if @group.update_attributes(params[:group])
          format.html { redirect_to @group, notice: 'Group was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:error] = "You must be signed in to view this page"
      redirect_to signin_url
    end
  end

  def destroy
    if signed_in?
      @group = Group.find(params[:id])

      unless is_admin? @group.id
        flash[:error] = "You must be the group admin to edit it"
        redirect_to groups_url
      end
      
      @group.destroy

      @associations = @group.group_users
      @associations.each do |assoc|
        assoc.destroy
      end

      redirect_to groups_url
    else
      flash[:error] = "You must be signed in to view this page"
      redirect_to signin_url
    end
  end

  def is_admin? group_id
    if signed_in?
      gu = GroupUser.where("group_id = ? and user_id = ?", group_id, current_user.id).first
      if gu.nil?
        isadmin = false
      else
        isadmin = gu.admin
      end
    else
      isadmin = false
    end

    return isadmin
  end
end
