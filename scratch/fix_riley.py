import os

path = '/Users/serik08/Documents/FBI/Riley.lua'
with open(path, 'r', encoding='cp1251', errors='ignore') as f:
    content = f.read()

# 1. Imports and variables
if 'local dkjson = require \'dkjson\'' not in content:
    content = content.replace("local vkeys = require 'vkeys'", "local vkeys = require 'vkeys'\nlocal dkjson = require 'dkjson'")
    content = content.replace("local u8 = encoding.UTF8", "local u8 = encoding.UTF8\n\nlocal myRank = \"Не определен\"\nlocal myOrg = \"Не определена\"")

# 2. Greeting message changes
old_role = 'role = u8"Разработчик (Основатель)"'
new_role = 'role = u8"Основатель скрипта"'
content = content.replace(old_role, new_role)

# Update the chat messages colors and add rank display
old_welcome = 'sampAddChatMessage(u8:decode(string.format("{FFFF00}[Riley System] {FFFFFF}%s. Добро пожаловать.", cleanName)), -1)'
new_welcome = 'sampAddChatMessage(u8:decode(string.format("{00D2FF}[Riley System] {FFFFFF}%s. Добро пожаловать.", cleanName)), -1)'
content = content.replace(old_welcome, new_welcome)

old_auth = 'sampAddChatMessage(u8:decode(string.format("{FFFF00}[Riley System] {FFFFFF}Вы успешно авторизованы как {00FF00}%s{FFFFFF}. Приятного пользования.", role)), -1)'
new_auth = 'sampAddChatMessage(u8:decode(string.format("{00D2FF}[Riley System] {FFFFFF}Вы успешно авторизованы как {00FF00}%s{FFFFFF}.", role)), -1)\n                \n                lua_thread.create(function()\n                    wait(1000)\n                    if myRank ~= "Не определен" then\n                        sampAddChatMessage(u8:decode(string.format("{00D2FF}[Riley System] {FFFFFF}Ваш текущий статус: {FFFA00}%s {FFFFFF}в {FFFA00}%s{FFFFFF}.", myRank, myOrg)), -1)\n                    end\n                end)'
content = content.replace(old_auth, new_auth)

# 3. onServerMessage detection logic
detection_code = """
    -- Детекция ранга и организации
    local d_text = u8:decode(text)
    if d_text:find("Вы успешно вошли!") or d_text:find("Организация:") then
        local rank, org = d_text:match("Вы вошли как (.*) %[(.*)%]")
        if not rank then
            org, rank = d_text:match("Организация: (.*), Должность: (.*)")
        end
        if rank and org then
            myRank = rank
            myOrg = org
        end
    end
"""

if 'myRank = rank' not in content:
    content = content.replace("function sampev.onServerMessage(color, text)\n    if not isSampAvailable() then return end", 
                              "function sampev.onServerMessage(color, text)\n    if not isSampAvailable() then return end" + detection_code)

# 4. JSON fix
content = content.replace('local data = decodeJson(content)', 'local data = dkjson.decode(content)')

with open(path, 'w', encoding='cp1251') as f:
    f.write(content)

print("Modification complete.")
