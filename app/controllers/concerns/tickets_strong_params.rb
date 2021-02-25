# Brimir is a helpdesk system to handle email support requests.
# Copyright (C) 2012-2016 Ivaldi https://ivaldi.nl/
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

module TicketsStrongParams
  extend ActiveSupport::Concern

  protected

  def ticket_params
    ok_agent_params = [
      :name,
      :to_email_address_id,
      :content,
      :subject,
      :status,
      :assignee_id,
      :priority,
      :message_id,
      :content_type
    ]

    if !current_user.nil? #&& current_user.agent?
      ok_agent_params = ok_agent_params.prepend(:from)
      if Tenant.current_tenant.ticket_creation_is_open_to_the_world?
        unless params[:ticket][:from]
          params[:ticket][:from] = current_user.email
        end
      end
      params.require(:ticket).permit(
        *ok_agent_params,
        attachments_attributes: [
          :file
        ])
    else
      ok_params = [
        :name,
        :content,
        :subject,
        :priority,
        :content_type,
      ]
      if Tenant.current_tenant.ticket_creation_is_open_to_the_world?
        ok_params = ok_params.prepend(:from)
      end
      params.require(:ticket).permit(
        *ok_params,
        attachments_attributes: [
          :file
        ])
    end
  end

end
