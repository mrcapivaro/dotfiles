local M = {}

M.installServers = function(servers)
  if servers and #servers > 0 then
    vim.cmd("MasonInstall " .. table.concat(servers, " "))
  end
end

return M
