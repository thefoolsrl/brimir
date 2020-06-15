module VirusTotalException
  class ThreatFound < StandardError
  end
end

class VirusTotalClient
  def initialize(malicious_threshold = 0, suspicious_threshold = 0, timeout = 20)
    @client = VirusTotal::API.new(key: Rails.application.secrets[:virustotal_key])
    @malicious_threshold = malicious_threshold
    @suspicious_threshold = suspicious_threshold
    @timeout = timeout
  end

  def analyze_file(file)
    return true if ["test", "development"].include?(Rails.env)
    id = @client.file.upload(File.expand_path(file))["data"]["id"]
    await_and_evaluate_id id
  end

  def analyze_file_path(file_path)
    return true if ["test", "development"].include?(Rails.env)
    id = @client.file.upload(file_path)["data"]["id"]
    await_and_evaluate_id id
  end

  def analyze_file_path!(file_path)
    return true if ["test", "development"].include?(Rails.env)
    id = @client.file.upload(file_path)["data"]["id"]
    raise VirusTotalException::ThreatFound unless await_and_evaluate_id id
  end

  def analyze_url(url)
    return true if ["test", "development"].include?(Rails.env)
    id = @client.url.analyse(url)["data"]["id"]
    await_and_evaluate_id id
  end

  private

  def evaluate(attributes)
    return false if attributes["suspicious"] > @suspicious_threshold || attribute["malicious"] > @malicious_threshold
    attributes["harmless"] > attributes["timeout"] + attributes["suspicious"] + attribute["malicious"]
  end

  def await_and_evaluate_id(id)
    sleep 2.seconds
    i = 0
    no_timeout = -> {i < @timeout}
    while @client.analysis.get(id)["data"]["attributes"]["status"] != "completed" || no_timeout.call
      sleep 10.seconds
      i += 1
    end
    return false unless no_timeout.call
    evaluate(@client.analysis.get(id)["data"]["attributes"])
  end
end