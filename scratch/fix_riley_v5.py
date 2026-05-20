import os
import re

path = '/Users/serik08/Documents/FBI/Riley.lua'

# Try reading as UTF-8
try:
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    print("Read successful as UTF-8")
except UnicodeDecodeError:
    print("UTF-8 read failed, falling back to bytes")
    with open(path, 'rb') as f:
        content_bytes = f.read()
    content = content_bytes.decode('utf-8', errors='replace')

# 1. Update role
content = content.replace('Разработчик (Основатель)', 'Основатель скрипта')

# 2. Update colors
content = content.replace('{FFFF00}[Riley System]', '{00D2FF}[Riley System]')

# 3. Update auth message
content = content.replace('Вы успешно авторизованы как {00FF00}%s{FFFFFF}. Приятного пользования.', 
                         'Вы успешно авторизованы как {00FF00}%s{FFFFFF}.')

# 4. Add rank display logic
rank_display = """
                lua_thread.create(function()
                    wait(1000)
                    if myRank ~= "Не определен" then
                        sampAddChatMessage(u8:decode(string.format("{00D2FF}[Riley System] {FFFFFF}Ваш текущий статус: {FFFA00}%s {FFFFFF}в {FFFA00}%s{FFFFFF}.", myRank, myOrg)), -1)
                    end
                end)
"""

if 'Ваш текущий статус' not in content:
    # Match the whole auth message line to be sure
    pattern = r'(sampAddChatMessage\(u8:decode\(string\.format\("{00D2FF}\[Riley System\] {FFFFFF}Вы успешно авторизованы как {00FF00}%s{FFFFFF}\.", role\)\), -1\))'
    content = re.sub(pattern, r'\1' + rank_display, content)

# 5. Correct my previous garbage values if any
content = content.replace('local myRank = " "', 'local myRank = "Не определен"')
content = content.replace('local myOrg = " "', 'local myOrg = "Не определена"')

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Modification complete (UTF-8).")
