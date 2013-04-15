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
      @isadmin = GroupUser.where("group_id = ? and user_id = ?", @group.id, current_user.id).first.admin

      messages = GroupMessage.where("group_id = ?", @group.id)
      @message = ""
      messages.each do |msg|
        @message << "#{msg.message}\n"
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
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    @associations = @group.group_users
    @associations.each do |assoc|
      assoc.destroy
    end

    redirect_to groups_url
  end
end
