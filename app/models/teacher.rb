class Teacher < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  has_secure_password allow_blank: true

  has_many :teacher_courses
  has_many :courses, through: :teacher_courses

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
    update_attribute(reset_digest: Teacher.digest(reset_token))
  end
end
