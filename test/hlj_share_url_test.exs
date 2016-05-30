defmodule HljShareUrlTest do

  use ExUnit.Case
  doctest HljShareUrl

  test "basic title injecting" do
    input = "http://www.example.org/"
    assert HljShareUrl.from( input, %{ title: "test" }) == "http://www.example.org/?hlj_title=test"
  end

  test "with user info" do
    input = "http://user:pass@www.example.org/"
    assert HljShareUrl.from( input, %{ title: "test" }) == "http://user:pass@www.example.org/?hlj_title=test"
  end

  test "with port" do
    input = "http://user:pass@www.example.org:8080/"
    assert HljShareUrl.from( input, %{ title: "test" }) == "http://user:pass@www.example.org:8080/?hlj_title=test"
  end

  test "https" do
    input = "https://user:pass@www.example.org:8080/"
    assert HljShareUrl.from( input, %{ title: "test" }) == "https://user:pass@www.example.org:8080/?hlj_title=test"
  end

  test "with path" do
    input = "https://user:pass@www.example.org:8080/path/to/resource"
    assert HljShareUrl.from( input, %{ title: "test" }) == "https://user:pass@www.example.org:8080/path/to/resource?hlj_title=test"
  end

  test "with fragment" do
    input = "https://user:pass@www.example.org:8080/#anchor"
    assert HljShareUrl.from( input, %{ title: "test" }) == "https://user:pass@www.example.org:8080/?hlj_title=test#anchor"
  end

  test "subtitle" do
    input = "http://www.example.org/"
    assert HljShareUrl.from( input, %{ sub_title: "test" }) == "http://www.example.org/?hlj_content=test"
  end
end
