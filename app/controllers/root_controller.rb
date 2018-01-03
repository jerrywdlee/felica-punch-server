class RootController < ApplicationController
  def index
    @routes = %w(admins users cards punch_logs)
  end
end
