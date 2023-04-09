require "test_helper"

class WorkersControllerTest < ActionDispatch::IntegrationTest
  include ParsedResponse
  include WorkerSupport
  include WorkerAsserts
  
  test 'get index: success' do
    get_workers_index

    assert_response :success
  end

  test 'get show: success' do
    worker = workers(:worker_one)
    get_worker_show(worker)

    assert_response :success
  end

  test 'post create: success' do
    params = worker_params

    post_worker_create(params)

    assert_response :ok
    worker_response_asserts
  end

  test 'post create: invalid params' do
    params = invalid_worker_params

    post_worker_create(params)

    assert_response :unprocessable_entity
  end

  test 'put update: success' do
    params = worker_params

    put_worker_update(workers(:worker_one).id, params)

    assert_response :created
    worker_response_asserts
  end

  test 'delete destroy: success' do
    worker = workers(:worker_one)

    delete_worker_destroy(worker)

    assert_response :no_content
  end  

  private

  def get_workers_index
    get v1_workers_path
  end

  def get_worker_show(worker)
    get v1_worker_path(worker)
  end

  def post_worker_create(params)
    post v1_workers_path, params: params
  end

  def put_worker_update(worker_id, params)
    put v1_worker_path(worker_id), params: params
  end

  def delete_worker_destroy(worker)
    delete v1_worker_path(worker.id)
  end
end
