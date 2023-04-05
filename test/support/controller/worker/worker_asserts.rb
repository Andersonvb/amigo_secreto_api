module WorkerAsserts
  def worker_response_asserts
    worker = Worker.find_by_id(response_data['id'])

    assert_equal worker_valid_keys, response_data.keys, 'Worker - Keys'
    assert_equal worker.id, response_data['id'], 'Worker - ID'
    assert_equal worker.name, response_data['name'], 'Worker - Name'
    assert_equal worker.location.name, response_data['location'], 'Worker - Location'
  end
end