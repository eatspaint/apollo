class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  serialize :rspot, Hash
  has_many :rooms

  def self.whosinhere
    who = []
    User.all.each do |u|
       who << "#{u.first_name} #{u.last_name}: #{u.sign_in_count}"
    end
    puts who
  end
end
