class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  has_many :notifications, dependent: :destroy
  validates :name, presence: true

  def self.find_for_google(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(provider: auth.provider,
                         email:    User.dummy_email(auth),
                         image:    auth.info.image,
                         uid:      auth.uid,
                         token:    auth.credentials.token,
                         password: Devise.friendly_token[0, 20],
                         name: auth.info.name)
    end
    user
  end

  private
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@omniauthable.com"
    end
end
