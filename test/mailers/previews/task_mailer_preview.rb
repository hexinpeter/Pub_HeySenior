# Preview all emails at http://localhost:3000/rails/mailers/task_mailer
class TaskMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/task_mailer/create_email
  def create_email
    TaskMailer.create_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/task_mailer/apply_email
  def apply_email
    TaskMailer.apply_email
  end

  # Preview this email at http://localhost:3000/rails/mailers/task_mailer/accept_email
  def accept_email
    TaskMailer.accept_email
  end

end
