local M = {}

function M.require_optional(unit)
	local status, value = pcall(require, unit)
	if status then
		print("successfully loaded optional module " .. unit)
	else
		print("Failed to load optional module" .. unit)
	end
end

return M
