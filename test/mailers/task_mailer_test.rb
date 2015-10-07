require 'test_helper'

class TaskMailerTest < ActionMailer::TestCase
  test "create_email" do
    mail = TaskMailer.create_email
    assert_equal "Create email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "apply_email" do
    mail = TaskMailer.apply_email
    assert_equal "Apply email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "accept_email" do
    mail = TaskMailer.accept_email
    assert_equal "Accept email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
