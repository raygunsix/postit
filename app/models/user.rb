class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 3 }, on: :create

  sluggable_column :username

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) # TODO ensure unique pin
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def send_pin_to_twillio
    # set up a client to talk to the Twilio REST API
    client = Twilio::REST::Client.new(
      ENV['twillio_account_sid'],
      ENV['twillio_auth_token']
    )

    sms = client.account.sms.messages.create(
      :body => "Please enter your PIN to login: #{self.pin}",
      :to => "+14108675309",
      :from => "+15005550006"
    )
  end

  def admin?
    self.role == "admin"
  end

end
