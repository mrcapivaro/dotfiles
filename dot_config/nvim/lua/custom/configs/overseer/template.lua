local filetypes = {
    "c",
    "cpp",
}

for i, k in ipairs(filetypes) do
    filetypes[i] = "templates." .. k
end

return filetypes
