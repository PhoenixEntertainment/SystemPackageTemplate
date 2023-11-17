local FileSystem = require("@lune/fs")
local Process = require("@lune/process")

local DirectoriesToClone = {
	{"","../Temp"},
	{"../src/Client/Packages","../Packages"},
	{"../src/Server/ServerPackages","../ServerPackages"},
	{"../src/Server/Packages","../Packages"}
}

local function CopyDirectory(SourceDir,TargetDir)
	for _,FileName in pairs(FileSystem.readDir(SourceDir)) do
		if FileSystem.isDir(SourceDir .. "/" .. FileName) then
			FileSystem.writeDir(TargetDir .. "/" .. FileName)
			CopyDirectory(SourceDir .. "/" .. FileName, TargetDir .. "/" .. FileName)
		else
			FileSystem.copy(SourceDir .. "/" .. FileName,TargetDir .. "/" .. FileName,{overwrite = true})
		end
	end
end

Process.spawn("wally",{"install","--project-path","../src/Server"},{stdio = "inherit"})
Process.spawn("wally",{"install","--project-path","../src/Client"},{stdio = "inherit"})

for _,Directories in pairs(DirectoriesToClone) do
	if FileSystem.isDir(Directories[2]) then
		FileSystem.removeDir(Directories[2])
	end
	FileSystem.writeDir(Directories[2])
end

for _,Directories in pairs(DirectoriesToClone) do
	if FileSystem.isDir(Directories[1]) then
		CopyDirectory(Directories[1],Directories[2])
	end
end

Process.spawn("rojo",{"build","../testenv.project.json","-o","../Temp/CurrentBuild.rbxl"},{stdio = "inherit"})