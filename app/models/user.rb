class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

=begin (i might use this code to attach profile image to users)
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:profiles/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

=end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :authentication_keys => {email: true, login: false}

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  #attr_accessor :login

  # add case insensitivity to your validations on :username
  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }

  #MySQL users: the use of the SQL lower function below is most likely unnecessary
  # and will cause any index on the email column to be ignored:

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end


  def login=(login)
    @login = login
  end
  def login
    @login || self.username || self.email
  end

  has_many :comments, dependent: :destroy
  has_many :movies
  has_many :galleries
  has_many :reviews, dependent: :destroy

end
