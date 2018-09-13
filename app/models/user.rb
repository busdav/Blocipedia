class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # add  `:confirmable`  back in; deactivated temporarily to make testing easier


  # If want to login with username:
  # attr_writer :login
  #
  # def login
  #   @login || self.username || self.email
  # end

  # validates :username, presence: :true, uniqueness: { case_sensitive: false }

  has_many :collaborators
  has_many :wikis
  has_many :shared_wikis, through: :collaborators, source: :wiki


  after_initialize :set_default_role, :if => :new_record?
  enum role: [:standard, :premium, :admin]


  private

  def set_default_role
    self.role ||= :standard
  end

  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  #   elsif conditions.has_key?(:username) || conditions.has_key?(:email)
  #     where(conditions.to_h).first
  #   end
  # end
end
