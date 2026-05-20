import os
import re

path = '/Users/serik08/Documents/FBI/Riley.lua'
with open(path, 'r', encoding='cp1251', errors='ignore') as f:
    lines = f.readlines()

for i in range(len(lines)):
    # Replace the role line
    if 'Разработчик' in lines[i] and 'role =' in lines[i]:
        lines[i] = lines[i].replace('Разработчик (Основатель)', 'Основатель скрипта')
    
    # Replace the color
    lines[i] = lines[i].replace('{FFFF00}[Riley System]', '{00D2FF}[Riley System]')
    
    # Replace the greetings string
    if 'Приятного пользования' in lines[i]:
        lines[i] = lines[i].replace('. Приятного пользования.', '.')
        # Add rank logic right after this line
        lines[i] += '\n                lua_thread.create(function()\n                    wait(1000)\n                    if myRank ~= "Не определен" then\n                        sampAddChatMessage(u8:decode(string.format("{00D2FF}[Riley System] {FFFFFF}Ваш текущий статус: {FFFA00}%s {FFFFFF}в {FFFA00}%s{FFFFFF}.", myRank, myOrg)), -1)\n                    end\n                end)\n'

with open(path, 'w', encoding='cp1251') as f:
    f.writelines(lines)

print("Fourth attempt by lines complete.")
