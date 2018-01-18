if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("diamond.exs", __DIR__)
end

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule DiamondTest do
  use ExUnit.Case

  test "letter A" do
    shape = Diamond.build_shape(?A)
    assert shape == "A\n"
  end

  test "letter C" do
    shape = Diamond.build_shape(?C)

    assert shape == """
           \s A \s
           \sB B\s
           C   C
           \sB B\s
           \s A \s
           """
  end

  test "letter E" do
    shape = Diamond.build_shape(?E)

    assert shape == """
           \s   A   \s
           \s  B B  \s
           \s C   C \s
           \sD     D\s
           E       E
           \sD     D\s
           \s C   C \s
           \s  B B  \s
           \s   A   \s
           """
  end

  describe "build_range/1" do
    test "returns A..A for A" do
      assert Diamond.build_range(?A) == 'A'
    end

    test "returns A..C..A for C" do
      assert Diamond.build_range(?C) == 'ABCBA'
    end

    test "returns A..E..A for E" do
      assert Diamond.build_range(?E) == 'ABCDEDCBA'
    end
  end

  describe "line/1" do
    test "returns \"A\" for A" do
      assert Diamond.line(?A) == "A"
    end

    test "returns \"B B\" for B" do
      assert Diamond.line(?B) == "B B"
    end
  end

  describe "size/1" do
    test "returns 1 for A" do
      assert Diamond.size(?A) == 1
    end

    test "returns 5 for C" do
      assert Diamond.size(?C) == 5
    end

    test "returns 9 for E" do
      assert Diamond.size(?E) == 9
    end
  end
end
