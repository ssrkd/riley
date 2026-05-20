import re
import sys

def decode_cp1251_escapes(text):
    # Process both \xHH and \\xHH cases and decode as CP1251
    return re.sub(r'\\+x([0-9a-fA-F]{2})', lambda m: bytes([int(m.group(1), 16)]).decode('cp1251', errors='replace'), text)

filename = 'helper.lua'
try:
    with open(filename, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()

    decoded_content = decode_cp1251_escapes(content)

    with open(filename, 'w', encoding='utf-8') as f:
        f.write(decoded_content)

    print(f"Decoding {filename} complete.")
except Exception as e:
    print(f"Error decoding {filename}: {e}")
