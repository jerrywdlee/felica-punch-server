class RootController < ApplicationController
  def index
    @routes = %w(admins devices users cards punch_logs)
  end
end
