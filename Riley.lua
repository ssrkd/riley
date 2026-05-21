local mimgui = require 'mimgui'
local encoding = require 'encoding'
local sampev = require 'lib.samp.events'
local inicfg = require 'inicfg'
local ffi = require 'ffi'
local vkeys = require 'vkeys'
encoding.default = 'CP1251'
local u8 = encoding.UTF8

local script_version = 5.0
local version_url = "https://raw.githubusercontent.com/ssrkd/riley/main/Rileyversion.json"
local update_url = "https://raw.githubusercontent.com/ssrkd/riley/main/Riley.lua"

-- Supabase конфигурация
local supabase_url = "https://zfwdxcmbtbopqwptxxnv.supabase.co"
local supabase_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inpmd2R4Y21idGJvcHF3cHR4eG52Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzkzNzEwNDYsImV4cCI6MjA5NDk0NzA0Nn0.c69GBgXsTa_hhZe9aPSnYRvN-GcMtDB9Ukt1in0ei-0"

-- Кэш ролей пользователей
local userRoles = {}
local rolesLoaded = false

local showMenu = mimgui.new.bool(false)
local showAct = mimgui.new.bool(false)
local currentTab = mimgui.new.int(1)

local directIni = "RileySystem.ini"
local defaultSettings = {
    main = {
        where = true,
        time = true,
        autohi = true,
        fastspeed = false,
        autocorrect = true,
        autohi_text = u8:encode("Да-да, на связи."),
        siren_enabled = true,
        carlock_enabled = true,
        driftmode_enabled = false,
        dev_color = "FFFFFF",
        tester_color = "FF0000"
    }
}

local founders = {
    ["Sakura Riley"] = true,
    ["Mark Travmatov"] = true,
    ["Kai Riley"] = true
}

local testers = {
    ["Klim Rozhdestvensky"] = true,
    ["Klim_Rozhdestvensky"] = true
}

local ini = inicfg.load(defaultSettings, directIni)

local function hexToFloat(hex)
    if not hex or type(hex) ~= "string" or #hex < 6 then hex = "FFFFFF" end
    local r = tonumber(hex:sub(1,2), 16) or 255
    local g = tonumber(hex:sub(3,4), 16) or 255
    local b = tonumber(hex:sub(5,6), 16) or 255
    return {r / 255, g / 255, b / 255}
end

local function floatToHex(floatArr)
    local r = math.floor(floatArr[0] * 255)
    local g = math.floor(floatArr[1] * 255)
    local b = math.floor(floatArr[2] * 255)
    return string.format("%02X%02X%02X", r, g, b)
end

local devColorArr = hexToFloat(ini.main.dev_color)
local testerColorArr = hexToFloat(ini.main.tester_color)

local settings = {
    where = mimgui.new.bool(ini.main.where),
    time = mimgui.new.bool(ini.main.time),
    autohi = mimgui.new.bool(ini.main.autohi),
    fastspeed = mimgui.new.bool(ini.main.fastspeed),
    autocorrect = mimgui.new.bool(ini.main.autocorrect),
    autohiText = mimgui.new.char[256](u8:decode(ini.main.autohi_text)),
    sirenEnabled = mimgui.new.bool(ini.main.siren_enabled),
    carlockEnabled = mimgui.new.bool(ini.main.carlock_enabled),
    driftModeEnabled = mimgui.new.bool(ini.main.driftmode_enabled),
    devColor = mimgui.new.float[3](devColorArr[1], devColorArr[2], devColorArr[3]),
    testerColor = mimgui.new.float[3](testerColorArr[1], testerColorArr[2], testerColorArr[3])
}

local function saveSettings()
    ini.main.where = settings.where[0]
    ini.main.time = settings.time[0]
    ini.main.autohi = settings.autohi[0]
    ini.main.fastspeed = settings.fastspeed[0]
    ini.main.autocorrect = settings.autocorrect[0]
    ini.main.autohi_text = u8:encode(ffi.string(settings.autohiText))
    ini.main.siren_enabled = settings.sirenEnabled[0]
    ini.main.carlock_enabled = settings.carlockEnabled[0]
    ini.main.driftmode_enabled = settings.driftModeEnabled[0]
    ini.main.dev_color = floatToHex(settings.devColor)
    ini.main.tester_color = floatToHex(settings.testerColor)
    inicfg.save(ini, directIni)
end

local function isDeveloper()
    if not isSampAvailable() then return false end
    local _, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
    if not myId then return false end
    local myName = sampGetPlayerNickname(myId)
    if not myName then return false end
    local cleanName = myName:gsub("_", " ")
    
    return userRoles[cleanName] == "owner" or userRoles[myName] == "owner"
end

local function isTester()
    if not isSampAvailable() then return false end
    local _, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
    if not myId then return false end
    local myName = sampGetPlayerNickname(myId)
    if not myName then return false end
    local cleanName = myName:gsub("_", " ")
    
    return userRoles[cleanName] == "tester" or userRoles[myName] == "tester"
end

-- HTTP POST запрос с headers через ffi
local function httpPost(url, body, headers, callback)
    local wininet = ffi.load("wininet")
    
    ffi.cdef[[
        typedef void* HINTERNET;
        HINTERNET InternetOpenA(const char* lpszAgent, DWORD dwAccessType, const char* lpszProxy, const char* lpszProxyBypass, DWORD dwFlags);
        HINTERNET InternetConnectA(HINTERNET hInternet, const char* lpszServerName, INTERNET_PORT nServerPort, const char* lpszUsername, const char* lpszPassword, DWORD dwService, DWORD dwFlags, DWORD_PTR dwContext);
        HINTERNET HttpOpenRequestA(HINTERNET hConnect, const char* lpszVerb, const char* lpszObjectName, const char* lpszVersion, const char* lpszReferrer, const char* lpszAcceptTypes, DWORD dwFlags, DWORD_PTR dwContext);
        BOOL HttpSendRequestA(HINTERNET hRequest, const char* lpszHeaders, DWORD dwHeadersLength, const void* lpOptional, DWORD dwOptionalLength);
        BOOL InternetReadFile(HINTERNET hFile, void* lpBuffer, DWORD dwNumberOfBytesToRead, DWORD* lpdwNumberOfBytesRead);
        BOOL InternetCloseHandle(HINTERNET hInternet);
        typedef unsigned short INTERNET_PORT;
    ]]
    
    local hInternet = wininet.InternetOpenA("Riley", 1, nil, nil, 0)
    if hInternet == nil then return false end
    
    local hConnect = wininet.InternetConnectA(hInternet, supabase_url:match("https://(.+)"), 443, nil, nil, 3, 0, 0)
    if hConnect == nil then
        wininet.InternetCloseHandle(hInternet)
        return false
    end
    
    local hRequest = wininet.HttpOpenRequestA(hConnect, "POST", "/rest/v1/users", nil, nil, nil, 0, 0)
    if hRequest == nil then
        wininet.InternetCloseHandle(hConnect)
        wininet.InternetCloseHandle(hInternet)
        return false
    end
    
    -- Формируем headers
    local headers_str = ""
    for k, v in pairs(headers) do
        headers_str = headers_str .. k .. ": " .. v .. "\r\n"
    end
    
    local success = wininet.HttpSendRequestA(hRequest, headers_str, #headers_str, body, #body)
    if not success then
        wininet.InternetCloseHandle(hRequest)
        wininet.InternetCloseHandle(hConnect)
        wininet.InternetCloseHandle(hInternet)
        return false
    end
    
    wininet.InternetCloseHandle(hRequest)
    wininet.InternetCloseHandle(hConnect)
    wininet.InternetCloseHandle(hInternet)
    
    return true
end

-- Загрузка ролей из Supabase через GET запрос (apikey в URL)
local function loadRolesFromSupabase()
    local url = supabase_url .. "/rest/v1/users?select=nickname,role&apikey=" .. supabase_key
    
    downloadUrlToFile(url, getWorkingDirectory() .. "/config/roles_tmp.json", function(id, status, p1, p2)
        if status == 6 then
            lua_thread.create(function()
                wait(500)
                local f = io.open(getWorkingDirectory() .. "/config/roles_tmp.json", "r")
                if f then
                    local content = f:read("*a")
                    f:close()
                    os.remove(getWorkingDirectory() .. "/config/roles_tmp.json")
                    
                    local ok, data = pcall(loadstring("return " .. content))
                    if ok and data and type(data) == "table" then
                        userRoles = {}
                        for _, user in ipairs(data) do
                            if user.nickname and user.role then
                                userRoles[user.nickname] = user.role
                            end
                        end
                        rolesLoaded = true
                    end
                end
            end)
        end
    end)
end

local function isFounder()
    return isDeveloper()
end

local speedTextDrawId = -1

local function applyCustomStyle()
    local style = mimgui.GetStyle()
    local colors = style.Colors
    local clr = mimgui.ImVec4
    
    style.WindowRounding = 10.0
    style.ChildRounding = 8.0
    style.FrameRounding = 6.0
    style.PopupRounding = 8.0
    style.ScrollbarRounding = 6.0
    style.TabRounding = 6.0
    style.WindowTitleAlign = mimgui.ImVec2(0.5, 0.5)
    style.WindowPadding = mimgui.ImVec2(15, 15)
    style.ItemSpacing = mimgui.ImVec2(10, 10)
    
    -- Премиальная стилистика "Midnight Dark"
    colors[mimgui.Col.WindowBg] = clr(0.07, 0.08, 0.10, 1.00)
    colors[mimgui.Col.ChildBg] = clr(0.10, 0.11, 0.13, 1.00)
    colors[mimgui.Col.PopupBg] = clr(0.07, 0.08, 0.10, 1.00)
    colors[mimgui.Col.Border] = clr(0.18, 0.20, 0.25, 0.50)
    colors[mimgui.Col.FrameBg] = clr(0.13, 0.14, 0.17, 1.00)
    colors[mimgui.Col.FrameBgHovered] = clr(0.18, 0.20, 0.25, 1.00)
    colors[mimgui.Col.FrameBgActive] = clr(0.22, 0.24, 0.29, 1.00)
    colors[mimgui.Col.TitleBg] = clr(0.07, 0.08, 0.10, 1.00)
    colors[mimgui.Col.TitleBgActive] = clr(0.10, 0.11, 0.13, 1.00)
    colors[mimgui.Col.Button] = clr(0.13, 0.14, 0.17, 1.00)
    colors[mimgui.Col.ButtonHovered] = clr(0.18, 0.20, 0.25, 1.00)
    colors[mimgui.Col.ButtonActive] = clr(0.25, 0.45, 0.90, 1.00)
    colors[mimgui.Col.Header] = clr(0.25, 0.45, 0.90, 0.80)
    colors[mimgui.Col.HeaderHovered] = clr(0.25, 0.45, 0.90, 0.90)
    colors[mimgui.Col.HeaderActive] = clr(0.25, 0.45, 0.90, 1.00)
    colors[mimgui.Col.Separator] = clr(0.18, 0.20, 0.25, 1.00)
    colors[mimgui.Col.Tab] = clr(0.10, 0.11, 0.13, 1.00)
    colors[mimgui.Col.TabHovered] = clr(0.18, 0.20, 0.25, 1.00)
    colors[mimgui.Col.TabActive] = clr(0.25, 0.45, 0.90, 1.00)
    colors[mimgui.Col.CheckMark] = clr(0.25, 0.45, 0.90, 1.00)
    colors[mimgui.Col.Text] = clr(0.95, 0.95, 0.95, 1.00)
    colors[mimgui.Col.TextDisabled] = clr(0.40, 0.42, 0.48, 1.00)
    colors[mimgui.Col.SliderGrab] = clr(0.25, 0.45, 0.90, 0.80)
    colors[mimgui.Col.SliderGrabActive] = clr(0.25, 0.45, 0.90, 1.00)
end

mimgui.OnInitialize(function()
    applyCustomStyle()
end)

local function mimguiTabButton(name, tabId)
    local isSelected = currentTab[0] == tabId
    if isSelected then
        mimgui.PushStyleColor(mimgui.Col.Button, mimgui.ImVec4(0.2, 0.2, 0.2, 1.0))
    end
    if mimgui.Button(name, mimgui.ImVec2(-1, 35)) then
        currentTab[0] = tabId
    end
    if isSelected then
        mimgui.PopStyleColor(1)
    end
end

mimgui.OnFrame(function() return showMenu[0] end, function()
    local res = mimgui.GetIO().DisplaySize
    mimgui.SetNextWindowPos(mimgui.ImVec2(res.x / 2, res.y / 2), mimgui.Cond.FirstUseEver, mimgui.ImVec2(0.5, 0.5))
    mimgui.SetNextWindowSize(mimgui.ImVec2(650, 420), mimgui.Cond.FirstUseEver)
    
    if mimgui.Begin("Riley System | Панель управления", showMenu, mimgui.WindowFlags.NoCollapse) then
        mimgui.BeginChild("Sidebar", mimgui.ImVec2(150, 0), true)
        
        mimgui.Text("Меню скрипта")
        mimgui.Separator()
        
        mimguiTabButton("Главная", 1)
        mimguiTabButton("Настройки", 2)
        mimguiTabButton("О скрипте", 3)
        
        if isDeveloper() then
            mimgui.Spacing()
            mimgui.Separator()
            mimguiTabButton("Owner Access", 4)
        end
        
        mimgui.EndChild()
        mimgui.SameLine()
        
        mimgui.BeginChild("MainContent", mimgui.ImVec2(0, 0), true)
        
        if currentTab[0] == 1 then
            mimgui.Text("Главная информация")
            mimgui.Separator()
            mimgui.TextColored(mimgui.ImVec4(0.00, 0.82, 1.00, 1.0), "Разработчик скрипта: Sakura Riley | Mark Travmatov | Kai Riley")
            mimgui.Spacing()
            mimgui.Text("Список доступных команд:")
            mimgui.Text("/where [id] - запросить местоположение")
            mimgui.Text("/act - меню взаимодействий")
            mimgui.Text("/rh - настройки скрипта")
            mimgui.Text("Клавиша Z - быстрая сирена (в авто)")
            mimgui.Text("Клавиша L - закрыть/открыть авто (Car Lock)")
            mimgui.Text("L.Shift - дрифт-мод (в авто)")
            
        elseif currentTab[0] == 2 then
            mimgui.Text("Основные настройки")
            mimgui.Separator()
            if mimgui.Checkbox("Команда /where", settings.where) then saveSettings() end
            if mimgui.Checkbox("FastSpeed", settings.fastspeed) then saveSettings() end
            mimgui.SameLine()
            mimgui.TextDisabled("(?)")
            if mimgui.IsItemHovered() then
                mimgui.BeginTooltip()
                mimgui.Text("Ежесекундно обновляет спидометр, убирая задержку отображения скорости.")
                mimgui.EndTooltip()
            end
            
            mimgui.Spacing()
            mimgui.Text("Горячие клавиши")
            mimgui.Separator()
            if mimgui.Checkbox("Клавиша Z (Быстрая сирена)", settings.sirenEnabled) then saveSettings() end
            if mimgui.Checkbox("Открыть/Закрыть авто (Клавиша L)", settings.carlockEnabled) then saveSettings() end
            if mimgui.Checkbox("Дрифт-мод (Левый Shift)", settings.driftModeEnabled) then saveSettings() end
            
            mimgui.Spacing()
            if mimgui.Checkbox("AutoHi (Автоответ при /p)", settings.autohi) then saveSettings() end
            if settings.autohi[0] then
                mimgui.PushItemWidth(300)
                if mimgui.InputText("Текст при ответе", settings.autohiText, 256) then saveSettings() end
                mimgui.PopItemWidth()
            end
            
            mimgui.Spacing()
            mimgui.Text("Настройки чата")
            mimgui.Separator()
            if mimgui.Checkbox("Автокоррекция сообщений", settings.autocorrect) then saveSettings() end
            if mimgui.IsItemHovered() then
                mimgui.BeginTooltip()
                mimgui.Text("Ставит заглавную букву и точку в конце. Работает и в рациях.")
                mimgui.EndTooltip()
            end
            

            
        elseif currentTab[0] == 3 then
            mimgui.Text("Обновления и информация")
            mimgui.Separator()
            mimgui.Text(string.format("Текущая версия скрипта: %.1f", script_version))
            mimgui.Spacing()
            mimgui.TextColored(mimgui.ImVec4(0.9, 0.7, 0.1, 1.0), "Что нового было добавлено:")
            mimgui.Text("- Последнее обновление: 21 мая 2026 года.")
            mimgui.Text("- Добавлен полноэкранный MImGui интерфейс с вкладками.")
            mimgui.Text("- Меню разделено на сайдбар (как в продвинутых хелперах).")
            mimgui.Text("- Рабочий автокорректор для команд /r, /f, /s, /d, /m.")
            mimgui.Text("- Исключена точка при использовании /me.")
            mimgui.Text("- Добавлена возможность включать/отключать клавишу Z.")
            mimgui.Text("- Переделана система сирены и блокировка поворота головы.")
            mimgui.Text("- Интегрирован Car Lock (на клавишу L).")
            mimgui.Text("- Добавлен Drift Master (удержание L.Shift).")
            mimgui.Spacing()
            mimgui.TextColored(mimgui.ImVec4(1.0, 1.0, 0.0, 1.0), "Для быстрой перезагрузки/обновления нажмите: CTRL + R")

        elseif currentTab[0] == 4 and isDeveloper() then
            mimgui.Text("Информационная панель владельца")
            mimgui.Separator()
            
            mimgui.Text("Текущий состав команды:")
            mimgui.Spacing()
            
            mimgui.TextColored(mimgui.ImVec4(0.0, 1.0, 1.0, 1.0), "Владельцы:")
            local hasOwners = false
            for nickname, role in pairs(userRoles) do
                if role == "owner" and not nickname:find("_") then
                    mimgui.Text("- " .. nickname)
                    hasOwners = true
                end
            end
            if not hasOwners then mimgui.Text("Список владельцев пуст.") end
            
            mimgui.Spacing()
            mimgui.TextColored(mimgui.ImVec4(1.0, 0.3, 0.3, 1.0), "Тестеры:")
            local hasTesters = false
            for nickname, role in pairs(userRoles) do
                if role == "tester" and not nickname:find("_") then
                    mimgui.Text("- " .. nickname)
                    hasTesters = true
                end
            end
            if not hasTesters then mimgui.Text("Список тестеров пуст.") end
            
            mimgui.Spacing()
            mimgui.Separator()
            mimgui.Text("Команды управления:")
            mimgui.Spacing()
            
            if mimgui.Button("/listusers") then
                sampSendChat("/listusers")
            end
            
            if mimgui.Button("/addowner [ник]") then
                sampSendChat("/addowner")
            end
            
            if mimgui.Button("/addtester [ник]") then
                sampSendChat("/addtester")
            end
            
            if mimgui.Button("/removeuser [ник]") then
                sampSendChat("/removeuser")
            end
            
            mimgui.Spacing()
            mimgui.TextWrapped("{FF0000}Внимание: Изменения сохраняются локально (в памяти). При перезагрузке скрипта изменения сбросятся. Для постоянного хранения добавьте/удалите пользователей в Supabase Dashboard.")
            mimgui.Spacing()
            mimgui.Text("Управление цветами в рации")
            mimgui.Separator()
            if mimgui.ColorEdit3("Цвет Владельцев", settings.devColor) then saveSettings() end
            if mimgui.ColorEdit3("Цвет Тестеров", settings.testerColor) then saveSettings() end
        end
        
        mimgui.EndChild()
        
        mimgui.End()
    end
end)

mimgui.OnFrame(function() return showAct[0] end, function()
    local res = mimgui.GetIO().DisplaySize
    mimgui.SetNextWindowPos(mimgui.ImVec2(res.x / 2 + 100, res.y / 2), mimgui.Cond.FirstUseEver, mimgui.ImVec2(0.5, 0.5))
    mimgui.SetNextWindowSize(mimgui.ImVec2(320, 260), mimgui.Cond.FirstUseEver)
    
    if mimgui.Begin("Riley System | Взаимодействие", showAct, mimgui.WindowFlags.NoCollapse) then
        mimgui.Text("Основные действия:")
        mimgui.Separator()
        
        if mimgui.Button("Сбросить снаряжение (Броня + Оружие)", mimgui.ImVec2(-1, 35)) then
            lua_thread.create(function()
                sampSendChat("/armoff")
                wait(500)
                sampSendChat("/drop")
            end)
            showAct[0] = false
        end
        mimgui.Spacing()

        if mimgui.Button("Спросить не нужна ли помощь", mimgui.ImVec2(-1, 30)) then
            lua_thread.create(function()
                sampSendChat(u8:decode("Здравствуйте, вам нужна помощь?"))
            end)
            showAct[0] = false
        end

        mimgui.Spacing()
        mimgui.Text("Департамент (Допросные):")
        mimgui.Separator()
        
        local function occupyInterrogation(dept)
            lua_thread.create(function()
                sampSendChat(u8:decode("/f to " .. dept .. ": Занимаем вашу допросную."))
            end)
            showAct[0] = false
        end
        
        if mimgui.Button("Занять допросную в LSPD", mimgui.ImVec2(-1, 30)) then occupyInterrogation("LSPD") end
        if mimgui.Button("Занять допросную в SFPD", mimgui.ImVec2(-1, 30)) then occupyInterrogation("SFPD") end
        if mimgui.Button("Занять допросную в LVPD", mimgui.ImVec2(-1, 30)) then occupyInterrogation("LVPD") end

        mimgui.Spacing()
        if mimgui.Button("Закрыть", mimgui.ImVec2(-1, 25)) then
            showAct[0] = false
        end
        mimgui.End()
    end
end)

local function processAutocorrect(text, noDot)
    if not text or #text == 0 then return text end
    if not settings.autocorrect[0] then return text end
    
    -- Замена сокращений на полные слова
    local lowerText = text:lower()
    if lowerText == "n" or lowerText == "rn" or lowerText == "fn" then
        text = "нет"
    elseif lowerText == "ps" then
        text = "пас"
    end
    
    local first = text:sub(1,1)
    if first == "" then return text end
    
    if first:match("%l") then
        first = string.upper(first)
    else
        local byte = string.byte(first)
        if byte then
            if byte >= 224 and byte <= 255 then
                first = string.char(byte - 32)
            elseif byte == 184 then
                first = string.char(168)
            end
        end
    end
    
    text = first .. text:sub(2)
    
    if not noDot then
        local last = text:sub(-1)
        if not (last == "." or last == "!" or last == "?" or last == ")" or last == "]") then
            text = text .. "."
        end
    end
    
    return text
end

function sampev.onSendChat(message)
    if settings.autocorrect[0] then
        message = processAutocorrect(message, false)
        return {message}
    end
end

function sampev.onSendCommand(cmd)
    local prefix, text = cmd:match("^(%S+)%s*(.*)$")
    local cmdLower = cmd:lower()
    
    if cmdLower == "/p" and settings.autohi[0] then
        lua_thread.create(function()
            wait(300)
            sampSendChat(u8:decode(ffi.string(settings.autohiText)))
        end)
    end

    if settings.autocorrect[0] and prefix and text and #text > 0 then
        local lowerPref = prefix:lower()
        if lowerPref == "/r" or lowerPref == "/f" or lowerPref == "/rn" or lowerPref == "/fn" or lowerPref == "/s" or lowerPref == "/m" or lowerPref == "/d" or lowerPref == "/do" then
            text = processAutocorrect(text, false)
            return {prefix .. " " .. text}
        end
    end
end

function sampev.onServerMessage(color, text)
    if not isSampAvailable() then return end

    -- Проверка на рацию (стандартные паттерны: [R], [F], [Рация], [R..., [F...)
    if text:find("%[R%]") or text:find("%[F%]") or text:find(u8:decode("%[Рация")) or text:find("%[R") or text:find("%[F") then
        local hexColor = string.format("{%06X}", bit.band(bit.rshift(color, 8), 0xFFFFFF))
        local modified = text
        local changed = false
        
        local function checkAndHighlight(role, colorTag)
            for nickname, userRole in pairs(userRoles) do
                if userRole == role then
                    local name1 = nickname:gsub("_", " ")
                    local name2 = nickname:gsub(" ", "_")
                    
                    if modified:find(name1) or modified:find(name2) then
                        local target = modified:find(name1) and name1 or name2
                        local pattern = target:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
                        modified = modified:gsub(pattern, colorTag .. target .. hexColor)
                        changed = true
                    end
                end
            end
        end

        checkAndHighlight("owner", "{" .. floatToHex(settings.devColor) .. "}")
        checkAndHighlight("tester", "{" .. floatToHex(settings.testerColor) .. "}")
        
        if changed then
            return {color, modified}
        end
    end
end

function main()
    while not isSampLoaded() or not isSampfuncsLoaded() or not isSampAvailable() do
        wait(100)
    end
    
    loadRolesFromSupabase()
    
    sampRegisterChatCommand("rh", function()
        showMenu[0] = not showMenu[0]
    end)
    
    sampRegisterChatCommand("act", function()
        showAct[0] = not showAct[0]
    end)
    
    sampRegisterChatCommand("c", function(arg)
        if arg == "60" then
            if isDeveloper() or isTester() then
                sampSendChat(u8:decode('/me смотрит на свои часы марки Rolex с гравировкой «Riley System»'))
            end
            sampSendChat("/c 60")
        else
            sampSendChat("/c " .. arg)
        end
    end)
    
    sampRegisterChatCommand("where", function(arg)
        if not settings.where[0] then return end
        if arg == "" then
            sampAddChatMessage(u8:decode("Используйте: /where [id]"), -1)
        else
            local id = tonumber(arg)
            if not id or not sampIsPlayerConnected(id) then
                sampAddChatMessage(u8:decode("Игрок не в сети или неверно указан ID."), -1)
            else
                local name = sampGetPlayerNickname(id)
                name = string.gsub(name, "_", " ")
                sampSendChat(u8:decode(string.format("/r %s, доложите Ваше местоположение.", name)))
            end
        end
    end)
    
    -- Команды управления пользователями (только для владельцев)
    sampRegisterChatCommand("addowner", function(arg)
        if not isDeveloper() then
            sampAddChatMessage(u8:decode("{FF0000}[Riley System] {FFFFFF}Только владельцы могут использовать эту команду."), -1)
            return
        end
        if arg == "" then
            sampAddChatMessage(u8:decode("Используйте: /addowner [ник]"), -1)
            return
        end
        
        -- Добавляем локально
        userRoles[arg] = "owner"
        userRoles[arg:gsub(" ", "_")] = "owner"
        sampAddChatMessage(u8:decode(string.format("{FFFF00}[Riley System] {FFFFFF}%s добавлен как владелец (локально). Добавьте в Supabase Dashboard для постоянного хранения.", arg)), -1)
        
        -- TODO: Добавить HTTP POST запрос к Supabase
    end)
    
    sampRegisterChatCommand("addtester", function(arg)
        if not isDeveloper() then
            sampAddChatMessage(u8:decode("{FF0000}[Riley System] {FFFFFF}Только владельцы могут использовать эту команду."), -1)
            return
        end
        if arg == "" then
            sampAddChatMessage(u8:decode("Используйте: /addtester [ник]"), -1)
            return
        end
        
        -- Добавляем локально
        userRoles[arg] = "tester"
        userRoles[arg:gsub(" ", "_")] = "tester"
        sampAddChatMessage(u8:decode(string.format("{FFFF00}[Riley System] {FFFFFF}%s добавлен как тестер (локально). Добавьте в Supabase Dashboard для постоянного хранения.", arg)), -1)
        
        -- TODO: Добавить HTTP POST запрос к Supabase
    end)
    
    sampRegisterChatCommand("removeuser", function(arg)
        if not isDeveloper() then
            sampAddChatMessage(u8:decode("{FF0000}[Riley System] {FFFFFF}Только владельцы могут использовать эту команду."), -1)
            return
        end
        if arg == "" then
            sampAddChatMessage(u8:decode("Используйте: /removeuser [ник]"), -1)
            return
        end
        
        -- Проверяем существует ли пользователь
        if not userRoles[arg] and not userRoles[arg:gsub(" ", "_")] then
            sampAddChatMessage(u8:decode(string.format("{FF0000}[Riley System] {FFFFFF}%s не найден в списке", arg)), -1)
            return
        end
        
        -- Удаляем локально
        userRoles[arg] = nil
        userRoles[arg:gsub(" ", "_")] = nil
        sampAddChatMessage(u8:decode(string.format("{FFFF00}[Riley System] {FFFFFF}%s удален (локально). Удалите из Supabase Dashboard для постоянного хранения.", arg)), -1)
        
        -- TODO: Добавить HTTP DELETE запрос к Supabase
    end)
    
    sampRegisterChatCommand("listusers", function()
        local _, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myName = myId and sampGetPlayerNickname(myId) or "unknown"
        local cleanName = myName:gsub("_", " ")
        local myRole = userRoles[cleanName] or userRoles[myName] or "none"
        
        if not isDeveloper() then
            sampAddChatMessage(u8:decode("{FF0000}[Riley System] {FFFFFF}Только владельцы могут использовать эту команду."), -1)
            return
        end
        
        sampAddChatMessage(u8:decode("{FFFF00}[Riley System] {FFFFFF}Список пользователей:"), -1)
        local shown = {}
        for nickname, role in pairs(userRoles) do
            -- Показываем только ники без подчеркиваний (без дубликатов)
            if not nickname:find("_") then
                local roleText = role == "owner" and "Владелец" or "Тестер"
                sampAddChatMessage(u8:decode(string.format("{FFFF00}[Riley System] {FFFFFF}%s - %s", nickname, roleText)), -1)
                shown[nickname] = true
            end
        end
    end)

    lua_thread.create(function()
        checkUpdate()
        while not sampIsLocalPlayerSpawned() do wait(100) end
        wait(2000)
        local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        if id then
            local name = sampGetPlayerNickname(id)
            if name then
                local cleanName = name:gsub("_", " ")
                
                -- Authorization logic
                local role = "Пользователь скрипта"
                
                if isDeveloper() then
                    role = "Разработчик скрипта"
                elseif isTester() then
                    role = "Тестер скрипта"
                end
                
                sampAddChatMessage(u8:decode(string.format("{FFFF00}[Riley System] {FFFFFF}%s. Добро пожаловать. Версия скрипта: %.1f", cleanName, script_version)), -1)
                sampAddChatMessage(u8:decode(string.format("{FFFF00}[Riley System] {FFFFFF}Вы успешно авторизованы как {00FF00}%s{FFFFFF}. Приятного пользования.", role)), -1)
            end
        end
    end)

    while true do
        wait(0)
        
        if not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then
            -- Быстрая сирена на Z (код из Siren on R.lua)
            if settings.sirenEnabled[0] and testCheat('z') and isCharInAnyCar(PLAYER_PED) then
                local car = storeCarCharIsInNoSave(PLAYER_PED)
                switchCarSiren(car, not isCarSirenOn(car))
            end

            -- Car Lock (на клавишу L / 76)
            if settings.carlockEnabled[0] and isKeyJustPressed(76) then
                sampSendChat("/lock")
            end
        end

        -- Drift Master logic (работает при зажатом L.Shift, независимо от чата, так как это управление авто)
        if settings.driftModeEnabled[0] and isCharInAnyCar(PLAYER_PED) then
            local car = storeCarCharIsInNoSave(PLAYER_PED)
            local speed = getCarSpeed(car)
            isCarInAirProper(car)
            setCarCollision(car, true)
            if isKeyDown(vkeys.VK_LSHIFT) and isVehicleOnAllWheels(car) and doesVehicleExist(car) and speed > 5.0 then
                setCarCollision(car, false)
                if isCarInAirProper(car) then setCarCollision(car, true)
                    if isKeyDown(vkeys.VK_A) then 
                        addToCarRotationVelocity(car, 0, 0, 0.15)
                    end
                    if isKeyDown(vkeys.VK_D) then             
                        addToCarRotationVelocity(car, 0, 0, -0.15)  
                    end
                end
            end
        end

        if settings.fastspeed[0] then
            if isCharInAnyCar(PLAYER_PED) then
                local car = storeCarCharIsInNoSave(PLAYER_PED)
                local speed = math.ceil(getCarSpeed(car) * 2)
                
                if speedTextDrawId and speedTextDrawId ~= -1 and sampTextdrawIsExists(speedTextDrawId) then
                    local txt = sampTextdrawGetString(speedTextDrawId)
                    if txt:find("Fuel") then
                        local newTxt = txt:gsub("%d+", tostring(speed), 1)
                        if txt ~= newTxt then
                            sampTextdrawSetString(speedTextDrawId, newTxt)
                        end
                    else
                        speedTextDrawId = -1
                    end
                else
                    for i = 0, 2304 do
                        if sampTextdrawIsExists(i) then
                            local txt = sampTextdrawGetString(i)
                            if txt:find("Fuel") then
                                speedTextDrawId = i
                                break
                            end
                        end
                    end
                end
            else
                speedTextDrawId = -1
            end
        end
    end
end

local function parseVersion(str)
    if not str then return nil end
    -- Прямое преобразование в число (работает для 3.10, 3.11 и т.д.)
    local val = tonumber(str)
    if val then return val end
    -- Если с запятой, заменяем на точку
    val = tonumber((str:gsub(",", ".")))
    if val then return val end
    -- Если с точкой как разделителем дробей, заменяем на запятую
    val = tonumber((str:gsub("%.", ",")))
    if val then return val end
    return nil
end

local function isValidLua(code)
    local loader = loadstring or load
    if not loader then return true end
    local ok, res = pcall(loader, code)
    return ok and res ~= nil
end

function checkUpdate()
    local config_dir = getWorkingDirectory() .. "/config"
    local f_path = config_dir .. "/riley_version.tmp"
    local update_tmp = config_dir .. "/riley_update.tmp"
    
    -- Ensure the config directory exists
    if not doesDirectoryExist(config_dir) then
        local ok, lfs = pcall(require, 'lfs')
        if ok and lfs then
            pcall(lfs.mkdir, config_dir)
        end
    end
    
    -- Добавляем timestamp для обхода кэша
    local cache_buster = "?t=" .. os.time()
    
    downloadUrlToFile(version_url .. cache_buster, f_path, function(id, status, p1, p2)
        if status == 6 then -- Download finished successfully
            lua_thread.create(function()
                local success, err = pcall(function()
                    wait(500) -- ждём освобождения файла системой
                    local f = io.open(f_path, "r")
                    if not f then
                        sampAddChatMessage(u8:decode("{FF0000}[Riley System] {FFFFFF}Ошибка: не удалось открыть локальный файл версии."), -1)
                        return
                    end
                    
                    local content = f:read("*a")
                    f:close()
                    os.remove(f_path)
                    
                    local version_str = content:match('"version"%s*:%s*([%d%.]+)') or content:match('"version"%s*:%s*(%d+%.?%d*)')
                    if version_str then
                        version_str = version_str:gsub("[,%s]", "")
                    end
                    
                    local new_version = parseVersion(version_str)
                    
                    if not new_version then
                        return
                    end
                    
                    local current_ver = parseVersion(tostring(script_version)) or script_version
                    
                    if new_version > current_ver then
                        sampAddChatMessage(u8:decode("{FFFF00}[Riley System] {FFFFFF}Есть обновление. Обновляю..."), -1)
                        
                        downloadUrlToFile(update_url, update_tmp, function(id2, status2, p12, p22)
                            if status2 == 6 then
                                lua_thread.create(function()
                                    local success2, err2 = pcall(function()
                                        wait(500)
                                        local f_up = io.open(update_tmp, "r")
                                        if not f_up then
                                            sampAddChatMessage(u8:decode("{FF0000}[Riley System] {FFFFFF}Ошибка чтения временного файла обновления."), -1)
                                            return
                                        end
                                        
                                        local update_content = f_up:read("*a")
                                        f_up:close()
                                        
                                        if not update_content or #update_content <= 1000 or not update_content:find("mimgui") or not isValidLua(update_content) then
                                            os.remove(update_tmp)
                                            sampAddChatMessage(u8:decode("{FF0000}[Riley System] {FFFFFF}Ошибка: скачанный файл поврежден или некорректен."), -1)
                                            return
                                        end
                                        
                                        local f_main = io.open(thisScript().path, "w")
                                        if not f_main then
                                            sampAddChatMessage(u8:decode("{FF0000}[Riley System] {FFFFFF}Ошибка: не удалось обновить файл скрипта."), -1)
                                            return
                                        end
                                        
                                        f_main:write(update_content)
                                        f_main:close()
                                        os.remove(update_tmp)
                                        
                                        sampAddChatMessage(u8:decode("{FFFF00}[Riley System] {FFFFFF}Успешно. Версия скрипта: " .. tostring(new_version)), -1)
                                        thisScript():reload()
                                    end)
                                    
                                    if not success2 then
                                        sampAddChatMessage(u8:decode(string.format("{FF0000}[Riley System] {FFFFFF}Ошибка при установке: %s", tostring(err2))), -1)
                                    end
                                end)
                            end
                        end)
                    else
                        -- Нет обновлений, молчим
                    end
                end)
                
                if not success then
                    sampAddChatMessage(u8:decode(string.format("{FF0000}[Riley System] {FFFFFF}Критическая ошибка авто-обновления: %s", tostring(err))), -1)
                end
            end)
        end
    end)
end

