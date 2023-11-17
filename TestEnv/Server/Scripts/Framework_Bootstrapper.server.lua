local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local DragonEngine = require(ReplicatedStorage.Packages.DragonEngine)

DragonEngine:Run({
	ShowLogoInOutput = false,
	Debug = true,
	ServerPaths = {
		ModulePaths = {
			Server = {
				ServerScriptService.Packages
			},
			Shared = {
				ReplicatedStorage.Packages
			}
		},
	
		ServicePaths = {
			ServerScriptService.Services
		}
	}
})