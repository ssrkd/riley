import os

# Read the file in UTF-8
with open('FBIhelper.lua', 'r', encoding='utf-8') as f:
    content = f.read()

# Write the file in CP1251
# Using 'replace' for errors to avoid crashing if there are unmappable chars,
# although for Russian text it should be fine.
with open('FBIhelper_cp1251.lua', 'w', encoding='cp1251', errors='replace') as f:
    f.write(content)

# Overwrite the original for compilation
os.rename('FBIhelper_cp1251.lua', 'FBIhelper.lua')

print("Conversion to CP1251 complete.")
