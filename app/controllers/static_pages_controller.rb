class StaticPagesController < ApplicationController
  def home
  	@groups = Group.all
  	@users = User.all
  end
  def help
  end
end
