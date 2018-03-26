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

# frozen_string_literal: true

require 'fog/core'

module Fog
  module Identity
    # Identity and authentication proxmox class
    class Proxmox < Fog::Service
      requires :pve_url, :username, :password
      recognizes :ticket, :csrftoken
    end

    request_path 'fog/identity/proxmox/requests'
    request :token_authenticate
    def self.new(args = {})
      url = Fog.credentials[:pve_url] || args[:pve_url]
      if url
        uri = URI(url)
      end
      service = Fog::Identity::Proxmox.new(args)
end
    # Mock class
    class Mock
      attr_reader :config

        def initialize(options = {})
          @proxmox_auth_uri = URI.parse(options[:pve_url])
          @config = options
        end
    end
    # Real class
    class Real
      include Fog::Proxmox::Core
      def initialize(options = {})
          initialize_identity(options)
          @connection_options       = options[:connection_options] || {}
          authenticate
          @persistent = options[:persistent] || false
          @connection = Fog::Core::Connection.new("#{@scheme}://#{@host}:#{@port}", @persistent, @connection_options)
      end
    end
  end
end
