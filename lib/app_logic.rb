DataMapper::setup(:default, ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/todo_list.db")

class User
  include DataMapper::Resource
  property :id, Serial
  property :username, String, required: true, length: 1..24, unique: true
  property :created_at, DateTime

  has n, :tasks

  def username= new_username
    super new_username.downcase
  end

  def self.authenticate(entered_username)
    if first(username: entered_username ) != nil
        return first(username: entered_username).username
    else
      return nil
    end
  end


end

class Task
  include DataMapper::Resource
  property :id, Serial
  property :content, String, required: true, length: 1..64
  property :completed, Boolean, required: true, default: false
  property :created_at, DateTime
  property :completed_at, DateTime

  belongs_to :user, required: true

end

DataMapper.finalize.auto_upgrade!
