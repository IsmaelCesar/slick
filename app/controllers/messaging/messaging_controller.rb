class Messaging::MessagingController < ApplicationController
  before_action :not_authorized?
end