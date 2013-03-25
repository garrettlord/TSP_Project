class GroupsController < ApplicationController
def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
    @users = User.all
  end

  def create
    @group = Group.new(name: params[:name])

    if @group.save
      flash[:success] = "New group successfully created!"

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
        format.html { redirect_to @group, notice: 'Event was successfully updated.' }
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
