local IDs = {
    2753915549,
    4442272183,
    7449423635,
}

if table.find(IDs, game.PlaceId) then

    loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasggk/Hop-fruit-BloxFruits/main/team.loader.lua"))()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")
    local LocalPlayer = Players.LocalPlayer
    local CommF_ = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
    local fruitCap = LocalPlayer:WaitForChild("Data"):WaitForChild("FruitCap").Value

    -- Armazenar qualquer fruta no Backpack ou Character
    local function armazenarFrutas()
        for _, container in ipairs({LocalPlayer.Backpack, LocalPlayer.Character}) do
            for _, tool in ipairs(container:GetChildren()) do
                if tool:IsA("Tool") and tool.Name:find("Fruit") then
                    local nomeBase = tool.Name:gsub(" Fruit", "")
                    local frutaID = nomeBase .. "-" .. nomeBase
                    local args = {
                        [1] = "StoreFruit",
                        [2] = frutaID,
                        [3] = tool
                    }
                    CommF_:InvokeServer(unpack(args))
                end
            end
        end
    end

    -- Coletar frutas do chão
    local function coletarFrutas()
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("Handle") and v.Name:find("Fruit") then
                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    firetouchinterest(hrp, v.Handle, 0)
                    firetouchinterest(hrp, v.Handle, 1)
                end
            end
        end
    end

    -- Remover notificações de "sem espaço"
    local function removerAvisos()
        for _, gui in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
            if gui:IsA("TextLabel") and gui.Text:find("only store ".. tostring(fruitCap) .. " of each") then
                gui:Destroy()
            end
        end
    end

    -- Loop contínuo
    RunService.Heartbeat:Connect(function()
        pcall(removerAvisos)
        pcall(coletarFrutas)
        pcall(armazenarFrutas)
    end)

else
    print("Game is not suported")
end
