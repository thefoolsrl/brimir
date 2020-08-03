class AttachmentValidator < ActiveModel::Validator
  def validate(record)
    client = VirusTotalClient.new
    record.attachments.each do |attachment|
      unless client.analyze_file_path(attachment.file_file_name)
        record.errors.add(:attachments, "Malicious file detected")
      end
    end
  end
end