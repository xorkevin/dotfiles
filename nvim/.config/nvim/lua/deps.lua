local Deps = {}

function Deps.new(self)
  local obj = {
    req = {},
    m = {},
    loaded = false,
  }
  self.__index = self
  return setmetatable(obj, self)
end

function Deps._compute_loaded(self)
  for _, k in ipairs(self.req) do
    if not self.m[k] then
      return false
    end
  end
  return true
end

function Deps.stats(self)
  local s = {}
  for _, k in ipairs(self.req) do
    if self.m[k] then
      s[k] = true
    else
      s[k] = false
    end
  end
  return s
end

function Deps.add_reqs(self, reqs)
  for _, k in ipairs(reqs) do
    table.insert(self.req, k)
  end
end

function Deps.provide(self, k, v)
  self.m[k] = v
  self.loaded = self:_compute_loaded()
end

Deps.singleton = Deps:new()

return Deps
