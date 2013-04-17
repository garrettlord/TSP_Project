require File.join(Rails.root, 'lib/twilio_helper.rb')

class PollsController < ApplicationController
  include TwilioHelper

  def new
    @poll = Poll.new
    @group_id = params[:group_id] || 1
  end

  def create
    @poll = Poll.new(params[:poll])


    if @poll.save
      group = @poll.group
      message = @poll.question + " Respond with 'poll #{@poll.id} <response>'"
      send_poll group, message
      flash[:message] = " Message Sent to #{group.name}: #{@poll.question}"

      flash[:success] = "New poll successfully created!"

      redirect_to @poll
    else
      flash[:failure] = "Could not save poll"
      render 'new'
    end
  end

  def show
    @poll = Poll.find(params[:id])
    isadmin = GroupUser.where("group_id = ? and user_id = ?", @poll.group_id, current_user.id).first.admin

    unless isadmin
      flash[:error] = "You must be the group admin to view this page"
      redirect_to root_url
    end

    @a_count = PollResponse.where('poll_id = ? AND response = ?', @poll.id, "a").size
    @b_count = PollResponse.where('poll_id = ? AND response = ?', @poll.id, "b").size
  end

  def destroy
    @poll = Poll.find(params[:id])
    group = @poll.group
    @poll.destroy

    redirect_to group_path(group)
  end
end
