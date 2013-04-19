require File.join(Rails.root, 'lib/twilio_helper.rb')

class PollsController < ApplicationController
  include TwilioHelper

  def new
    unless is_admin? params[:group_id]
      flash[:error] = "You must be a group admin to do that"
      redirect_to groups_url
      return
    end

    @poll = Poll.new
    @group_id = params[:group_id] || 1
  end

  def create
    unless is_admin? params[:poll][:group_id]
      flash[:error] = "You must be a group admin to do that"
      redirect_to groups_url
      return
    end

    @poll = Poll.new(params[:poll])
    if @poll.save
      group = @poll.group
      message = @poll.question + " Respond with 'poll #{@poll.id} <response>'"
      send_poll group, message
      flash[:message] = " Message Sent to #{group.name}: #{@poll.question}"

      flash[:success] = "New poll successfully created!"

      redirect_to @poll
      return
    else
      flash[:failure] = "Could not save poll"
      render 'new'
      return
    end
  end

  def show
    @poll = Poll.find(params[:id])

    unless is_admin? @poll.group_id
      flash[:error] = "You must be the group admin to view this page"
      redirect_to root_url
      return
    end

    @a_count = PollResponse.where('poll_id = ? AND response = ?', @poll.id, "a").size
    @b_count = PollResponse.where('poll_id = ? AND response = ?', @poll.id, "b").size
  end

  def destroy
    @poll = Poll.find(params[:id])

    unless is_admin? @poll.group_id
      flash[:error] = "You must be a group admin to do that"
      redirect_to groups_url
      return
    end

    
    group = @poll.group
    @poll.destroy

    redirect_to group_path(group)
  end

  def is_admin? group_id
    if signed_in?
      gu = GroupUser.where("group_id = ? and user_id = ?", group_id, current_user.id).first
      if gu.nil?
        logger.info "debug:: gu is nil"
        isadmin = false
      else
        logger.info "debug:: gu admin: #{gu.admin}"
        isadmin = gu.admin
      end
    else
      logger.info "debug:: not signed in"
      isadmin = false
    end

    return isadmin
  end
end
