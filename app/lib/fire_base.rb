class FireBase
  attr_reader :driver

  def initialize
    @private_key_json = File.open("#{Rails.root.to_s}/config/qakha-delivery-99.json").read
    @driver = Firebase::Client.new("https://qakha-delivery-99-default-rtdb.firebaseio.com", @private_key_json)
  end

  def get(path)
    @driver.get(path)
  end

  def set(path, data)
    @driver.set(path, data)
  end

  def delete(path)
    @driver.delete(path)
  end

  def push(path, data)
    @driver.push(path, data)
  end

  def update(path, data)
    @driver.update(path, data)
  end
end
