require 'test_helper'

class ClicksControllerTest < ActionDispatch::IntegrationTest

  cookie_name = ENV['COOKIE_NAME'] || 'SHTR'

  test "default" do

    assert_raise do
      get '/'
    end

    assert_raise do
      get '/xxx'
    end

    location = 'http://www.google.com/'
    Link.create(slug: 'yyy', url: location)
    get '/yyy'
    assert_response :redirect
    assert_equal response.headers['Location'], location
    click1 = Click.last

    # second request from same visitor
    get '/yyy'
    assert_response :redirect
    assert_equal response.headers['Location'], location
    click2 = Click.last

    # different clicks
    assert_not_equal click1, click2
    # but same visitor
    assert_equal     click1.visitor, click2.visitor

    # new request from another visitor
    cookies.delete(cookie_name)
    get '/yyy'
    assert_response :redirect
    assert_equal response.headers['Location'], location
    click3 = Click.last

    # different clicks
    assert_not_equal click2, click3
    # and different visitor
    assert_not_equal click2.visitor, click3.visitor
    assert_not_equal click2.visitor.hash_string, click3.visitor.hash_string

    # another visit from same visitor
    location2 = 'http://www.yandex.ru/'
    Link.create(slug: 'zzz', url: location2)
    get '/zzz'
    assert_response :redirect
    assert_equal response.headers['Location'], location2
    click4 = Click.last

    # different clicks
    assert_not_equal click3, click4
    # but same visitor
    assert_equal     click3.visitor, click4.visitor

    # visitor with get params (query)
    get '/zzz/bla-bla/?abc=def&ooo=ppp'
    assert_response :redirect
    assert_equal response.headers['Location'], location2
    click5 = Click.last

    # different clicks
    assert_not_equal click4, click5
    # but same visitor
    assert_equal     click4.visitor, click5.visitor

    assert_equal click5.clicked_url, '/zzz/bla-bla/?abc=def&ooo=ppp'

  end

end
