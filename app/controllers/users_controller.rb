class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @groups = Group.all
    @users = User.all
  end

  def new
    @user = User.new
    @groups = Group.all
  end

  def create
    @user = User.new
    @user.name = params[:name]
    @user.phone_number = params[:phone_number]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if @user.save
      sign_in @user
      flash[:success] = "Welcome to our project, #{@user.name}!"

      groups = Group.all
      groups.each do |group|
        if params["#{group.name}"]
          group_user = GroupUser.new(group_id: group.id, user_id: @user.id)
          unless group_user.save
            flash[:failure] = "Could not create the associations checked"
          end
        end
      end

      redirect_to @user
    else
      render 'new'
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    @associations = @user.group_users
    @associations.each do |assoc|
      assoc.destroy
    end

    redirect_to users_url
  end

  def group_message
    send_group_text Group.find(params[:group]).name, params[:message]
    flash[:message] = " Message Sent to #{Group.find(params[:group]).name}: #{params[:message]}"
    redirect_to "/users/#{params[:user_id]}"
  end
end
