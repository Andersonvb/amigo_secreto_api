module ParsedResponse
  def response_body
    JSON.parse(@response.body)
  end

  def response_data
    response_body['data']
  end

  def response_error_message
    response_body['error'][0]['code']
  end
end
