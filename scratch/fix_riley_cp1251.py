import os

path = '/Users/serik08/Documents/FBI/Riley.lua'
with open(path, 'r', encoding='utf-8', errors='replace') as f:
    content = f.read()

# 1. Make dkjson require safe
content = content.replace("local dkjson = require 'dkjson'", "local dkjson = nil\npcall(function() dkjson = require 'dkjson' end)")

# 2. Fix the JSON call (again, just to be sure)
content = content.replace('dkjson.decode(content)', '(dkjson and dkjson.decode(content) or nil)')

# 3. Ensure myRank/myOrg are initialized with valid strings
content = content.replace('local myRank = "Не определен"', 'local myRank = "Unknown"')
content = content.replace('local myOrg = "Не определена"', 'local myOrg = "Unknown"')

# 4. Write back as CP1251 (Windows-1251)
try:
    with open(path, 'w', encoding='cp1251', errors='replace') as f:
        f.write(content)
    print("Successfully wrote as CP1251")
except Exception as e:
    print(f"Failed to write as CP1251: {e}")
