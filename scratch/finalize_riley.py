import os
import re

path = '/Users/serik08/Documents/FBI/Riley.lua'
with open(path, 'r', encoding='utf-8', errors='replace') as f:
    content = f.read()

# 1. Safety for dkjson
if 'local dkjson' not in content:
    content = content.replace("local vkeys = require 'vkeys'", "local vkeys = require 'vkeys'\nlocal dkjson = nil\npcall(function() dkjson = require 'dkjson' end)")

# 2. Rename Developer in UI
content = content.replace('Разработчик скрипта:', 'Основатель скрипта:')
content = content.replace('Разработчики (Основатели):', 'Основатели скрипта:')

# 3. Fix JSON calls to be safe if dkjson is missing
content = content.replace('dkjson.decode(content)', '(dkjson and dkjson.decode(content) or nil)')

# 4. Fix potential garbage myRank/myOrg
content = re.sub(r'local myRank = ".*?"', 'local myRank = "Не определен"', content)
content = re.sub(r'local myOrg = ".*?"', 'local myOrg = "Не определена"', content)

# 5. Fix the sky blue color for all system messages (changed from FFFF00 to 00D2FF)
content = content.replace('{FFFF00}[Riley System]', '{00D2FF}[Riley System]')

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)

print("Final Polish complete.")
