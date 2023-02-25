local LspServers = {}

local overrides_defaults = {
  autoDocumentFormatDisable = nil
}

function LspServers.new(self)
  local obj = {
    servers = {},
    overrides = {},
  }
  self.__index = self
  return setmetatable(obj, self)
end

function LspServers.add_servers(self, servers)
  for _, server in ipairs(servers) do
    table.insert(self.servers, server)
    self.overrides[server.name] = vim.tbl_deep_extend('force', overrides_defaults, self.overrides[server.name] or {},
      server.overrides or {})
  end
end

LspServers.singleton = LspServers:new()

return LspServers
