class StaticPagesController < ApplicationController
  def home
    User.all.each { |user| user.save(validate: false) }
  	@groups = Group.all
  	@users = User.all
  end
  def help
  end
end
