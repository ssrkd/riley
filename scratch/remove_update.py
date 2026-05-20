import os
import re

path = '/Users/serik08/Documents/FBI/Riley.lua'
with open(path, 'r', encoding='cp1251', errors='replace') as f:
    content = f.read()

# 1. Remove variables related to updates
content = re.sub(r'local script_version = .*?\n', '', content)
content = re.sub(r'local version_url = .*?\n', '', content)

# 2. Remove checkUpdate() call inside the lua_thread
content = content.replace('checkUpdate()', '-- checkUpdate() removed')

# 3. Remove the entire checkUpdate() function definition
# It starts with 'function checkUpdate()' and ends with 'end' before 'function onWindowMessage'
# Based on previous sed: it was roughly from 552 to 580
pattern = r'function checkUpdate\(\).*?end\n\n(?=function onWindowMessage)'
content = re.sub(pattern, '', content, flags=re.DOTALL)

# 4. Remove dkjson related stuff if it was only for updates
content = content.replace("local dkjson = nil\npcall(function() dkjson = require 'dkjson' end)\n", "")
# And in the UI tabs part too (it was mentioning version)
content = content.replace('mimgui.Text(string.format(u8"Текущая версия скрипта: %.1f", script_version))', '-- version display removed')

with open(path, 'w', encoding='cp1251') as f:
    f.write(content)

print("Auto-update removed.")
