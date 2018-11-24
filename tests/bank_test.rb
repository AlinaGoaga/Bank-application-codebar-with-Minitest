require "minitest/autorun"
require_relative "../lib/atm"

class BankTest < Minitest::Test

  def check_without_balance_on_create
    atm = Atm.new()
    assert atm.balance == 0
  end

  def check_with_balance_on_create
    atm = Atm.new(12)
    assert atm.balance == 12
  end

  def  test_correct_deposit
     atm=Atm.new()
     assert atm.deposit(12, "01-01-2018") == {status: :ok, balance: 12}
  end

  def  test_incorrect_deposit
     atm=Atm.new()
     assert atm.deposit("duck", "01-01-2018") == {status: :fail, error: :malformed_import}
  end

  def test_correct_withdrawal
    atm=Atm.new(12)
    assert atm.withdrawal(10, "01-01-2018") == { status: :ok, balance: 2 }
  end

  def test_incorrect_withdrawal
      atm=Atm.new(12)
      assert atm.withdrawal("whale", "01-01-2018") == {status: :fail, error: :malformed_import}
  end

  def test_youre_too_poor
    atm=Atm.new(1)
    assert atm.withdrawal(100, "01-01-2018") == {status: :fail, error: :insufficient_funds}
  end

end

#tests for deposits and withdrawals
