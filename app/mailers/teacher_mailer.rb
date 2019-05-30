class TeacherMailer < ApplicationMailer

  def password_reset(teacher)
    @teacher = teacher
    mail to: teacher.email, subject: "Password reset"
  end
end
