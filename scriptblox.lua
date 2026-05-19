local imgui = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/HacksCreator102/ImGUI-/refs/heads/main/source.lua"
))()
--// SCRIPTBLOX TAB
local scriptTab = window:createTab("Script Search")

local searchBoxValue = ""
local lastResults = {}

local function searchScripts(query)
    if query == "" then return end

    local url = "https://scriptblox.com/api/script/search?q=" .. game:GetService("HttpService"):UrlEncode(query)

    local response = game:HttpGet(url)

    local data = game:GetService("HttpService"):JSONDecode(response)

    lastResults = data.result and data.result.scripts or {}
end

-- Search input (ImGui style)
scriptTab:AddInput({
    Name = "Search Scripts",
    Placeholder = "admin, fly, esp...",
    Callback = function(v)
        searchBoxValue = v
    end
})

scriptTab:AddButton({
    Name = "Search",
    Callback = function()
        searchScripts(searchBoxValue)
    end
})

scriptTab:AddLabel("Results:")

-- RESULTS UI REFRESH LOOP
task.spawn(function()
    while task.wait(1) do
        -- clear + rebuild simple result list (safe ImGui way)
        scriptTab:ClearChildren()

        scriptTab:AddInput({
            Name = "Search Scripts",
            Placeholder = "admin, fly, esp...",
            Callback = function(v)
                searchBoxValue = v
            end
        })

        scriptTab:AddButton({
            Name = "Search",
            Callback = function()
                searchScripts(searchBoxValue)
            end
        })

        scriptTab:AddLabel("Results:")

        for i, v in ipairs(lastResults) do
            local title = v.title or "No Title"
            local scriptCode = v.script or ""

            scriptTab:AddButton({
                Name = "Copy: " .. title,
                Callback = function()
                    if setclipboard and scriptCode ~= "" then
                        setclipboard(scriptCode)

                        imgui:notify(
                            "ScriptBlox",
                            "Copied: " .. title,
                            "rbxassetid://6031075938"
                        )
                    end
                end
            })
        end
    end
end)