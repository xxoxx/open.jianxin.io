class Account
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :name, :type => String
  field :email, :type => String
  field :github, :type => String
  field :blog, :type => String

  # You can define indexes on documents using the index macro:
  index({email: 1}, :unique => true)

  def self.find_by_id(id)
    unless id
      return nil
    end
    find(id)
  end

  def role
    if email == ENV['OPEN_ADMIN_EMAIL']
      return 'admin'
    end
    'user'
  end

  def self.create_with_omniauth(auth)
    create! ({
        name: auth['name'],
        email: auth['email'],
        github: auth['urls']['GitHub'],
        blog: auth['urls']['Blog']
    })
  end
end
