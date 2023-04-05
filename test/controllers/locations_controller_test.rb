require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  include ParsedResponse
  include LocationSupport
  include LocationAsserts

  test 'Index Locations' do
    get_locations_index

    assert_response :ok
    assert_equal Location.all.size, response_data.size, 'Index - Locations'
  end

  test 'Show Locations' do
    location = locations(:location_one)
    get_location_show(location)

    assert_response :ok
    assert_equal location_as_json('location_one'), response_data, 'Show - Locations'
  end

  test 'Create Locations' do
    params = location_params

    post_location_create(params)

    assert_response :ok
    location_response_asserts
  end

  test 'Invalid Create Locations' do
    params = invalid_location_params

    post_location_create(params)

    assert_response :unprocessable_entity
  end

  test 'Update Locations' do
    params = location_params

    put_location_update(locations(:location_one).id, params)

    assert_response :ok
    location_response_asserts
  end

  test 'Destroy Location' do
    location = Location.create(name: 'Example Location')

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

  def location_as_json(location_name)
    Location.find_by_name(location_name).as_json(
      only: [:id, :name],
      except: [:created_at, :updated_at]
    )
  end
end
