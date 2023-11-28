--
-- Premake5 file for build Vulkan-SDK project.
-- Copyright (c) 2023-present by Danil (Kenny) Dukhovenko, All rights reserved.
--
-- Requirement:
--  - ForceEngine.lua
--  - VulkanSDK installed
--
-- NOTE: This is thunk library, only with linkage .lib to VulkanSDK. All source code contains in
-- VulkanSDK/Include, etc.
-- Read more in ForceEngine.lua::About __NULL_IMPORT_DESCRIPTOR why i made this dicision.
--

-- Vulkan C++ Project
project "Vulkan"
	kind          "StaticLib"
	language      "C++"
	cppdialect    "C++17"
	staticruntime "on"
	targetdir     ("%{ForceDir.BinLib}/" .. BuildDir .. "/%{prj.name}/Lib")
	objdir        ("%{ForceDir.BinLib}/" .. BuildDir .. "/%{prj.name}/Obj")

	files {
		"%{IncludeDir.Vulkan}/**.h",
		"src/**.cpp"
	}

	includedirs {
		"%{IncludeDir.Vulkan}"
	}
	
	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

		links {
			"%{Library.Any.VKLayerUtils}",
			"%{Library.Dbg.ShaderC}",
			"%{Library.Dbg.SpirvCross}",
			"%{Library.Dbg.SpirvCrossGLSL}",
			"%{Library.Dbg.SpirvTools}"
		}

	filter "configurations:Release"
		runtime "Release"
		optimize "on"
		links {
			"%{Library.Any.VKLayerUtils}",
			"%{Library.Rel.ShaderC}",
			"%{Library.Rel.SpirvCross}",
			"%{Library.Rel.SpirvCrossGLSL}",
			"%{Library.Rel.SpirvTools}"
		}