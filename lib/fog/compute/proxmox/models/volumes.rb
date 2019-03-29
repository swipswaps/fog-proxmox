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

require 'fog/compute/proxmox/models/volume'

module Fog
  module Compute
    class Proxmox
      # class Volumes Collection of volumes
      class Volumes < Fog::Collection
        model Fog::Compute::Proxmox::Volume
        attribute :node_id
        attribute :storage_id

        def new(attributes = {})
          requires :node_id, :storage_id
          super({ node_id: node_id, storage_id: storage_id }.merge(attributes))
        end

        def all(filters = {})
          requires :node_id, :storage_id
          load service.list_volumes(node_id, storage_id, filters)
        end

        def list_by_content_type(content)
          requires :node_id
          all.select { |volume| volume.content.include? content}
        end

        def list_by_content_type_and_by_server(content, vmid)
          all(vmid: vmid)
        end

        def get(id)
          requires :node_id, :storage_id
          new service.get_volume(node: node_id, storage: storage_id, volume: id)
        end

        def destroy(id)
          volume = get(id)
          volume.destroy
        end
      end
    end
  end
end
