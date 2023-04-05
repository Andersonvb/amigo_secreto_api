module WorkerSupport
  def worker_params
    {
      worker: {
        name: 'New Worker',
        location_id: locations(:location_one).id
      }
    }
  end

  def invalid_worker_params
    {
      worker: {
        name: 'An',
        location_id: locations(:location_one).id
      }
    }
  end

  def worker_valid_keys
    %w[id name location year_in_work]
  end
end