require 'test_helper'

class API::V1::ApiLoginTest < ActionDispatch::IntegrationTest

  test 'should sign in using single sign on' do

    host! "test.host"

    post '/api/v1/sessions', params: {
      email: 'bob@xxxx.com', password: 'Testtest123!!'
    }

    assert_response :success

    result = JSON.parse @response.body

    assert_not_nil result['authorization_token']

    get '/api/v1/tickets.json',
      params: { 'auth_token': result['authorization_token'] }

    assert_response :success
  end

  test 'do not login with fault post' do
    post '/api/v1/sessions',
      params: { wrong_param: 'wrong' }

    assert_response :unauthorized

    result = JSON.parse @response.body

    assert_equal 'Wrong credentials', result['error']
  end

end
