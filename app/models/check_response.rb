class CheckResponse
  include Mongoid::Document

  # raw result is a hash include these fields:
  #   - check_id: string reference to the check
  #   - type: string either http|tcp currently
  #   - time:
  #       - action: value in seconds
  #       ...
  #   - body: string body of response
  #   - error: true/false
  #   - error_message: string
  #   - http:
  #       - http field
  #   - tcp:
  #       - tcp field
  #   - attbs:
  #       - name: value
  field :raw_result, type: Hash

  belongs_to :assertion

  def body
    raw_result['body']
  end

  def total_response_time
    time('total')
  end

  def time(action)
    raw_result['time'][action]
  end

  def code
    raw_result['http']['code']
  end

  def status
    if error.nil? || error
      'up'.freeze
    else
      'down'.freeze
    end
  end

  def error
    raw_result['error']
  end

  def errors
    Array.new raw_result['error'], raw_result['error_message']
  end

  def self.create_from_raw_result(result)
    raw_result = JSON.parse(result)
    new(raw_result: raw_result)
  end
end
