class Teacher < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  has_secure_password allow_blank: true

  has_many :teacher_courses
  has_many :courses, through: :teacher_courses

  attr_accessor :reset_token

  def Teacher.new_token
    SecureRandom.urlsafe_base64
  end

  def Teacher.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost

    BCrypt::Password.create(string,cost: cost)
  end

  def create_reset_digest
    self.reset_token = Teacher.new_token
    update_columns(reset_digest: Teacher.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    TeacherMailer.password_reset(self).deliver_now
  end

  def authenticated?(reset_token)
    BCrypt::Password.new(reset_digest).is_password?(reset_token)

  end
end
