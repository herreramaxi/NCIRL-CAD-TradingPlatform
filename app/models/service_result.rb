class ServiceResult
  attr_reader :succeeded, :errorMessage, :data

  def initialize(succeeded, errorMessage)
    @succeeded = succeeded
    @errorMessage = errorMessage
  end

  def initialize(succeeded)
    @succeeded = succeeded
  end

  def initialize; end

  def setAsSuccessful(data)
    @succeeded = true
    @data = data
    return self
  end

  def setAsFailed(errorMessage)
    @succeeded = false
    @errorMessage = errorMessage
    return self
  end
end
