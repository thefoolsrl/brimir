class AttachmentValidator < ActiveModel::Validator
  def validate(record)
    client = VirusTotalClient.new
    record.attachments.each do |attachment|
      next unless attachment.file.queued_for_write[:original]&.path
      unless client.analyze_file_path(attachment.file.queued_for_write[:original].path)
        record.errors.add(:attachments, "Malicious file detected")
      end
    end
  end
end