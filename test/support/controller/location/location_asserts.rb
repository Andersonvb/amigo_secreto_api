module LocationAsserts
  def location_response_asserts
    location = Location.find_by_id(response_data['id'])

    assert_equal location_valid_keys, response_data.keys, 'Location - Keys'
    assert_equal location.id, response_data['id'], 'Location - ID'
    assert_equal location.name, response_data['name'], 'Location - Name'
  end
end
