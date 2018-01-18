if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("nanp.exs", __DIR__)
end

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule NANPTest do
  use ExUnit.Case

  describe "NANP.new/1" do
    test "accepts style like (212) 555-0100" do
      nanp = NANP.new("(212) 555-0100")

      assert nanp.valid
      assert nanp.area_code == "212"
      assert nanp.exchange_code == "555"
      assert nanp.subscriber_number == "0100"
    end

    test "accepts style like 212.555.0100" do
      nanp = NANP.new("212.555.0100")

      assert nanp.valid
      assert nanp.area_code == "212"
      assert nanp.exchange_code == "555"
      assert nanp.subscriber_number == "0100"
    end

    test "accepts style like 12125550100" do
      nanp = NANP.new("12125550100")

      assert nanp.valid
      assert nanp.area_code == "212"
      assert nanp.exchange_code == "555"
      assert nanp.subscriber_number == "0100"
    end

    test "accepts style like +1 (212) 555-0100" do
      nanp = NANP.new("+1 (212) 555-0100")

      assert nanp.valid
      assert nanp.area_code == "212"
      assert nanp.exchange_code == "555"
      assert nanp.subscriber_number == "0100"
    end

    test "invalid if country calling code is not 1" do
      nanp = NANP.new("22125550100")

      refute nanp.valid
    end

    test "invalid if raw only has 9 digits" do
      nanp = NANP.new("212555010")

      refute nanp.valid
    end

    test "invalid if letter mixed in" do
      nanp = NANP.new("2a1a2a5a5a5a0a1a0a0a")

      refute nanp.valid
    end
  end
end
