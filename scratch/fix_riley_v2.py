import os
import re

path = '/Users/serik08/Documents/FBI/Riley.lua'
with open(path, 'r', encoding='cp1251', errors='ignore') as f:
    content = f.read()

# Fix role greeting message
content = re.sub(r'role = u8"Разработчик \(Основатель\)"', 'role = u8"Основатель скрипта"', content)

# Update welcome message colors (replace FFFF00 which is yellow with 00D2FF which is sky blue)
content = content.replace('{FFFF00}[Riley System]', '{00D2FF}[Riley System]')

# Fix the auth message text (remove "Приятного пользования" as it will be in the next line potentially or just clean it up)
# We want: Вы успешно авторизованы как [role].
content = re.sub(r'"{00D2FF}\[Riley System\] {FFFFFF}Вы успешно авторизованы как {00FF00}%s{FFFFFF}\..*?"', 
                 '"{00D2FF}[Riley System] {FFFFFF}Вы успешно авторизованы как {00FF00}%s{FFFFFF}."', content)

# Add rank display if not already there
if 'sampAddChatMessage(u8:decode(string.format("{00D2FF}[Riley System] {FFFFFF}Ваш текущий статус:' not in content:
    append_logic = r'\1\n                \n                lua_thread.create(function()\n                    wait(1000)\n                    if myRank ~= "Не определен" then\n                        sampAddChatMessage(u8:decode(string.format("{00D2FF}[Riley System] {FFFFFF}Ваш текущий статус: {FFFA00}%s {FFFFFF}в {FFFA00}%s{FFFFFF}.", myRank, myOrg)), -1)\n                    end\n                end)'
    content = re.sub(r'(sampAddChatMessage\(u8:decode\(string\.format\("{00D2FF}\[Riley System\] {FFFFFF}Вы успешно авторизованы как {00FF00}%s{FFFFFF}\.", role\)\), -1\))', 
                     append_logic, content)

# Correct the garbage characters if they appeared in myPrevious attempt
content = content.replace('local myRank = " "', 'local myRank = "Не определен"')
content = content.replace('local myOrg = " "', 'local myOrg = "Не определена"')

with open(path, 'w', encoding='cp1251') as f:
    f.write(content)

print("Second modification attempt complete.")
