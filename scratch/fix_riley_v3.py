import os
import re

path = '/Users/serik08/Documents/FBI/Riley.lua'
with open(path, 'r', encoding='cp1251', errors='ignore') as f:
    content = f.read()

# 1. Update role directly
content = content.replace('Разработчик (Основатель)', 'Основатель скрипта')

# 2. Update colors
content = content.replace('{FFFF00}[Riley System]', '{00D2FF}[Riley System]')

# 3. Update auth message - more robust match
content = re.sub(r'Вы успешно авторизованы как {00FF00}%s{FFFFFF}\. Приятного пользования\.', 
                 'Вы успешно авторизованы как {00FF00}%s{FFFFFF}.', content)

# 4. Add the rank display logic if missing
rank_display = """
                lua_thread.create(function()
                    wait(1000)
                    if myRank ~= "Не определен" then
                        sampAddChatMessage(u8:decode(string.format("{00D2FF}[Riley System] {FFFFFF}Ваш текущий статус: {FFFA00}%s {FFFFFF}в {FFFA00}%s{FFFFFF}.", myRank, myOrg)), -1)
                    end
                end)
"""

if 'Ваш текущий статус' not in content:
    content = content.replace('Вы успешно авторизованы как {00FF00}%s{FFFFFF}."', 
                             'Вы успешно авторизованы как {00FF00}%s{FFFFFF}."' + rank_display)

with open(path, 'w', encoding='cp1251') as f:
    f.write(content)

print("Third attempt with simple replace complete.")
