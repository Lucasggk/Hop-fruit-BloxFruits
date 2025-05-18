local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local placeId = game.PlaceId
local visited = {}
local maxTentativas = 10

-- Checa se o servidor já foi visitado
local function jaVisitado(jobId)
	for _, id in pairs(visited) do
		if id == jobId then
			return true
		end
	end
	return false
end

-- Tenta encontrar um servidor válido
local function encontrarServidor()
	for tentativa = 1, maxTentativas do
		local sucesso, dados = pcall(function()
			local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Desc&limit=100"
			return HttpService:JSONDecode(game:HttpGet(url))
		end)

		if sucesso and dados and dados.data then
			for _, servidor in pairs(dados.data) do
				local jobId = servidor.id
				if servidor.playing >= 10 and servidor.playing < servidor.maxPlayers and jobId ~= game.JobId and not jaVisitado(jobId) then
					table.insert(visited, jobId)
					return jobId
				end
			end
		end
		wait(1)
	end
	return nil
end

-- Faz o teleport
local function hopServer()
	local server = encontrarServidor()
	if server then
		print("Teleportando para servidor:", server)
		TeleportService:TeleportToPlaceInstance(placeId, server, Players.LocalPlayer)
	else
		warn("Nenhum servidor válido encontrado.")
	end
end

-- Executa
hopServer()
