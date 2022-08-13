for k in pairs(package.loaded) do
    if k:match(".*penumbra.*") then package.loaded[k] = nil end
end

require('penumbra').setup()
require('penumbra').colorscheme()
