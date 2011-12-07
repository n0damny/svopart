require 'test_helper'

class NoteadminTest < ActionMailer::TestCase
  test "order_received_adm" do
    mail = Noteadmin.order_received_adm
    assert_equal "Order received adm", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "order_changed_adm" do
    mail = Noteadmin.order_changed_adm
    assert_equal "Order changed adm", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
