class Admin::EndUsersController < ApplicationController
  def index
    @end_user = EndUser.with_deleted
  end
end
