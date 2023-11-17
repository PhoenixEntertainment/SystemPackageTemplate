while true do
	if shared.DragonEngine ~= nil then
		break
	else
		task.wait()
	end
end

local SystemClient = shared.DragonEngine:GetController("SystemClient")