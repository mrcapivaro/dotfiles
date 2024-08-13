local M = {}

M.installServers = function(servers, command)
  if servers and #servers > 0 then
    vim.cmd(command .. " " .. table.concat(servers, " "))
  end
end

return M
