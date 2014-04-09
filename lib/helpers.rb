helpers do
  def database_save_check(item)
    if item.save
      status 201
      redirect '/tasks'
    else
      status 412
      redirect '/tasks'
    end
  end
end


