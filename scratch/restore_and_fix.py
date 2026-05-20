import os
import re

path = '/Users/serik08/Documents/FBI/Riley.lua'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Add rank/org variables at the top (after script_version)
content = content.replace('local script_version = 1.1', 'local script_version = 1.1\n\nlocal myRank = "Не определен"\nlocal myOrg = "Не определена"')

# 2. Add detection logic to onServerMessage
detection_code = """
    -- Детекция ранга и организации
    if text:find(u8:decode("Вы успешно вошли!")) or text:find(u8:decode("Организация:")) then
        local rank, org = text:match(u8:decode("Вы вошли как (.*) %[(.*)%]"))
        if not rank then
            org, rank = text:match(u8:decode("Организация: (.*), Должность: (.*)"))
        end
        if rank and org then
            myRank = rank
            myOrg = org
        end
    end
"""

content = content.replace('function sampev.onServerMessage(color, text)\n    if not isSampAvailable() then return end', 
                          'function sampev.onServerMessage(color, text)\n    if not isSampAvailable() then return end' + detection_code)

# 3. Modify greeting in main thread
# Change role names
content = content.replace('"Разработчик (Основатель)"', '"Основатель скрипта"')
content = content.replace('"Тестер скрипта"', '"Тестер"')

# Update greeting messages and colors
# Old: sampAddChatMessage(u8:decode(string.format("{FFFF00}[Riley System] {FFFFFF}%s. Добро пожаловать.", cleanName)), -1)
# New: Sky blue color {00D2FF}
content = content.replace('{FFFF00}[Riley System]', '{00D2FF}[Riley System]')

# Add rank display to greeting
auth_msg_pattern = r'(sampAddChatMessage\(u8:decode\(string\.format\("{00D2FF}\[Riley System\] {FFFFFF}Вы успешно авторизованы как {00FF00}%s{FFFFFF}\. Приятного пользования\.", role\)\), -1\))'
rank_display_code = r'\1\n                \n                lua_thread.create(function()\n                    wait(1000)\n                    if myRank ~= "Не определен" then\n                        sampAddChatMessage(u8:decode(string.format("{00D2FF}[Riley System] {FFFFFF}Ваш текущий статус: {FFFA00}%s {FFFFFF}в {FFFA00}%s{FFFFFF}.", myRank, myOrg)), -1)\n                    end\n                end)'

content = re.sub(auth_msg_pattern, rank_display_code, content)

# 4. Remove auto-update
content = content.replace('checkUpdate()', '-- checkUpdate() removed')
# Remove function definition
pattern_update_func = r'function checkUpdate\(\).*?end\n\n(?=function onWindowMessage)'
content = re.sub(pattern_update_func, '', content, flags=re.DOTALL)
# Remove update URLs
content = re.sub(r'local update_url = .*?\n', '', content)
content = re.sub(r'local version_url = .*?\n', '', content)

# 5. UI name changes
content = content.replace('Разработчик скрипта:', 'Основатель скрипта:')

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Restoration and precise modification complete.")
