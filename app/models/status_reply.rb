class StatusReply < Reply

  def self.create_from_status_change(ticket, current_user)
    if ticket.closed?
      message = I18n.t(:your_ticket_has_been_closed, locale: ticket.user.locale)
      create_from_status_message message, ticket, current_user
    end
  end

  def self.create_from_assignment(ticket, current_user)
    message = I18n.t(:str_is_working_on_your_ticket, str: ticket.assignee.name, locale: ticket.user.locale)
    create_from_status_message message, ticket, current_user
  end

  def self.create_from_subject_change(ticket, old_subject, new_subject, current_user)
    message = I18n.t(:str1_has_renamed_ticket_from_str2_to_str3, str1: current_user.name, str2: old_subject, str3: new_subject)
    reply = create_from_status_message message, ticket, current_user
    reply.notified_users = []
    reply.save
    return reply
  end

  def self.create_from_status_message(message, ticket, current_user)
    reply = self.create content: message, ticket_id: ticket.id, user_id: current_user.id
    reply.reply_to = ticket
    reply.set_default_notifications!
    reply.notified_users = (reply.notified_users + [ticket.user] - [ticket.assignee] - [nil]).uniq
    return reply
  end

  def to_partial_path
    'replies/reply'
  end

end
