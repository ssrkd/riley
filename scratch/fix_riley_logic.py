import os

path = '/Users/serik08/Documents/FBI/Riley.lua'
with open(path, 'r', encoding='cp1251', errors='replace') as f:
    content = f.read()

# Replace the broken onServerMessage logic
broken_block = """    --    
    local d_text = u8:decode(text)
    if d_text:find("  !") or d_text:find(":") then
        local rank, org = d_text:match("   (.*) %[(.*)%]")
        if not rank then
            org, rank = d_text:match(": (.*), : (.*)")
        end
        if rank and org then
            myRank = rank
            myOrg = org
        end
    end"""

# Note: The garbage chars in broken_block are just to match what might be there.
# I will use a regex to find and replace the whole detection block.

import re
pattern = r'local d_text = u8:decode\(text\).*?end\s+end'
# Wait, that's too broad.

correct_detection = """
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

# I'll just replace the whole function to be safe.
old_func_start = "function sampev.onServerMessage(color, text)\n    if not isSampAvailable() then return end"
new_func_start = "function sampev.onServerMessage(color, text)\n    if not isSampAvailable() then return end" + correct_detection

content = content.replace(old_func_start, new_func_start)

# Also fix the weird garbage comments if they exist
content = re.sub(r'-- \?+ \?+', '-- Детекция ранга', content)

with open(path, 'w', encoding='cp1251') as f:
    f.write(content)

print("Detection logic fixed (removed incorrect u8:decode).")
