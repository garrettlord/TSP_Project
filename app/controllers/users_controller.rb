require File.join(Rails.root, 'lib/twilio_helper.rb')

class UsersController < ApplicationController
  include TwilioHelper

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @groups = Group.find(:all, conditions: {public: true})
    @groups_in = @user.all_groups
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
    user = User.find(params[:user_id])
    group = Group.find(params[:group])
    send_group_text user, group, params[:message]
    flash[:message] = " Message Sent to #{group.name}: #{params[:message]}"
    redirect_to "/users/#{user.id}"
  end

  def group_message_multiple
    user = User.find(params[:user_id])
    if !params[:groups].nil?
      flash[:message] = ""
      params[:groups].each do |group_id|
        group = Group.find(group_id)
        message = "#{group.name}: #{user.name} - #{params[:message]}"
        send_group_text user, group, message
        flash[:message] << "Message sent to #{group.name}: #{params[:message]}\n"
      end
    else
      flash[:error] = "Could not send any group messages"
    end
    
    redirect_to "/users/#{user.id}"
  end
end
