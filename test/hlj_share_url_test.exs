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

  test "with query" do
    input = "http://www.example.org/path?a=1"
    assert HljShareUrl.from( input, %{ sub_title: "test" }) == "http://www.example.org/path?hlj_content=test&a=1"
  end

  test "composite" do
    input     = "http://mp.weixin.qq.com/s?__biz=MzA4NTQyNDEwOA==&mid=504206688&idx=7&sn=e8bcb662c9a5cf3f0671d5e91c6e944b#rd"
    icon      = "http://hlj-img.b0.upaiyun.com/zmw/upload/share/share_img1.jpg"
    title     = "最帅伴郎彭于晏，亲授拍照新花样"
    sub_title = "搞怪彭于晏、无厘头倪妮教你绝密拍照大法"

    expected = "http://mp.weixin.qq.com/s?hlj_content=%E6%90%9E%E6%80%AA%E5%BD%AD%E4%BA%8E%E6%99%8F%E3%80%81%E6%97%A0%E5%8E%98%E5%A4%B4%E5%80%AA%E5%A6%AE%E6%95%99%E4%BD%A0%E7%BB%9D%E5%AF%86%E6%8B%8D%E7%85%A7%E5%A4%A7%E6%B3%95&hlj_icon_url=http%3A%2F%2Fhlj-img.b0.upaiyun.com%2Fzmw%2Fupload%2Fshare%2Fshare_img1.jpg&hlj_title=%E6%9C%80%E5%B8%85%E4%BC%B4%E9%83%8E%E5%BD%AD%E4%BA%8E%E6%99%8F%EF%BC%8C%E4%BA%B2%E6%8E%88%E6%8B%8D%E7%85%A7%E6%96%B0%E8%8A%B1%E6%A0%B7&__biz=MzA4NTQyNDEwOA%3D%3D&idx=7&mid=504206688&sn=e8bcb662c9a5cf3f0671d5e91c6e944b#rd"

    assert HljShareUrl.from(input, %{ icon: icon, title: title, sub_title: sub_title }) == expected
  end
  test "composite2" do
    input     = "http://mp.weixin.qq.com/s?__biz=MzA4NTQyNDEwOA==&mid=504206688&idx=6&sn=9a20e97a3ca378a4283ec8065a2ec8a4#rd"
    icon      = "http://hlj-img.b0.upaiyun.com/zmw/upload/share/share_img2.jpg"
    title     = "泰勒舒淇陈冠希，分分合合的一周"
    sub_title = "看明星一周热点，领文末福利"

    expected = "http://mp.weixin.qq.com/s?hlj_content=%E7%9C%8B%E6%98%8E%E6%98%9F%E4%B8%80%E5%91%A8%E7%83%AD%E7%82%B9%EF%BC%8C%E9%A2%86%E6%96%87%E6%9C%AB%E7%A6%8F%E5%88%A9&hlj_icon_url=http%3A%2F%2Fhlj-img.b0.upaiyun.com%2Fzmw%2Fupload%2Fshare%2Fshare_img2.jpg&hlj_title=%E6%B3%B0%E5%8B%92%E8%88%92%E6%B7%87%E9%99%88%E5%86%A0%E5%B8%8C%EF%BC%8C%E5%88%86%E5%88%86%E5%90%88%E5%90%88%E7%9A%84%E4%B8%80%E5%91%A8&__biz=MzA4NTQyNDEwOA%3D%3D&idx=6&mid=504206688&sn=9a20e97a3ca378a4283ec8065a2ec8a4#rd"

    assert HljShareUrl.from(input, %{ icon: icon, title: title, sub_title: sub_title }) == expected
  end

  test "only path" do
    input = "/path"
    title = "title"
    assert HljShareUrl.from(input, %{ title: title }) == "/path?hlj_title=title"
  end
end
