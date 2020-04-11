class Admin::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @end_user = EndUser.with_deleted
  end
end
