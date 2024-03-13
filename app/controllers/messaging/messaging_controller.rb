class Messaging::MessagingController < ApplicationController
  layout 'messaging'
  before_action :not_authorized?
end