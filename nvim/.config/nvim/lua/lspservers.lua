local LspServers = {}

local cfg_defaults = {
  cfg_reader = 'nvim-lspconfig',
  overrides = {
    autoDocumentFormatDisable = nil
  },
}

function LspServers.new(self)
  local obj = {
    servers = {},
    overrides = {},
    priority = {},
    max_prio = 0,
  }
  self.__index = self
  return setmetatable(obj, self)
end

function LspServers.add_servers(self, servers)
  for _, server in ipairs(servers) do
    server = vim.tbl_deep_extend('force', cfg_defaults, server)
    table.insert(self.servers, server)
    self.overrides[server.name] = vim.tbl_deep_extend('force', self.overrides[server.overrides] or {}, server.overrides)
    self.max_prio = self.max_prio + 1
    self.priority[server.name] = self.max_prio
  end
end

LspServers.singleton = LspServers:new()

return LspServers
