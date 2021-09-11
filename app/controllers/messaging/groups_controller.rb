class Messaging::GroupsController < Messaging::MessagingController

  def user_groups
    @user_groups = current_user.groups
  end

  def available_groups 
    @groups = Group.all
  end
end
