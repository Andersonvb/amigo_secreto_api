module LocationSupport
  def location_params
    {
      location: {
        name: 'New Location'
      }
    }
  end

  def invalid_location_params
    {
      location: {
        name: 'Lo'
      }
    }
  end

  def location_valid_keys
    %w[id name]
  end
end
