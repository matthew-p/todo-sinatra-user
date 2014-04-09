helpers do
  def database_save_check(item, success_route, fail_route)
    if item.save
      status 201
      redirect success_route
    else
      status 412
      redirect fail_route
    end
  end

  def get_session_user_from_params(user)
    User.new(username: params[:username])
  end

  def logged_in
    User.authenticate(session["user"]) != nil
  end

  def session_user
    User.first(username: session["user"])
  end







end


