class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

=begin (i might use this code to attach profile image to users)
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:profiles/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

=end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :movies
  has_many :galleries
end
