# frozen_string_literal: true

# Copyright 2018 Tristan Robert

# This file is part of Fog::Proxmox.

# Fog::Proxmox is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# Fog::Proxmox is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with Fog::Proxmox. If not, see <http://www.gnu.org/licenses/>.

module Fog
  module Proxmox
    class Compute
      # class Real action_server request
      class Real
        def action_server(path_params, body_params)
          node = path_params[:node]
          type = path_params[:type]
          action = path_params[:action]
          vmid = path_params[:vmid]
          request(
            expects: [200],
            method: 'POST',
            path: "nodes/#{node}/#{type}/#{vmid}/status/#{action}",
            body: URI.encode_www_form(body_params)
          )
        end
      end

      # class Mock action_server request
      class Mock
      end
    end
  end
end
