require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  include ParsedResponse
  include LocationSupport
  include LocationAsserts

  test 'get index: is successful' do
    get_locations_index

    assert_response :success
    assert_equal Location.all.size, response_data.size, 'Index - Locations'
  end

  test 'get show: is successful' do
    location = locations(:location_one)
    get_location_show(location)

    assert_response :success
  end

  test 'post create: successful' do
    params = location_params

    post_location_create(params)

    assert_response :success
    location_response_asserts
  end

  test 'post create: invalid params' do
    params = invalid_location_params

    post_location_create(params)

    assert_response :unprocessable_entity
  end

  test 'put update: successful' do
    params = location_params

    put_location_update(locations(:location_one).id, params)

    assert_response :success
    location_response_asserts
  end

  test 'put update: invalid params' do
    params = invalid_location_params

    put_location_update(locations(:location_one).id, params)

    assert_response :unprocessable_entity
  end

  test 'delete destroy: successful' do
    location = locations(:location_one)

    delete_location_destroy(location)

    assert_response :no_content
  end

  private

  def get_locations_index
    get v1_locations_path
  end

  def get_location_show(location)
    get v1_location_path(location)
  end

  def post_location_create(params = {})
    post v1_locations_path params: params
  end

  def put_location_update(location_id, params)
    put v1_location_path(location_id), params: params
  end

  def delete_location_destroy(location)
    delete v1_location_path(location.id)
  end
end
