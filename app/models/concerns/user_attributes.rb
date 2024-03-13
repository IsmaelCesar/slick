# @author Isamael Cesar <leamscesar@gmail.com>
# this module implements the methods to be used by the model to access the user attributes
module UserAttributes
  extend ActiveSupport::Concern
  def name
    friend.name
  end

  def email
    friend.email
  end

  def status
    friend.status
  end

  def online
    friend.online
  end

  def user_image_url
    friend.user_image_url
  end
end
