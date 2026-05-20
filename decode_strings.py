import re

def decode_cp1251_escapes(text):
    # Pattern for \xHH or \\xHH
    pattern = re.compile(r'(\\+x[0-9a-fA-F]{2})')
    
    def replace(match):
        hex_seq = match.group(1)
        # Extract the two hex digits (the last two chars)
        hex_val = hex_seq[-2:]
        try:
            # Convert hex to integer, then to a byte
            byte_val = int(hex_val, 16)
            # Only decode if it's in the extended ASCII range (likely Russian)
            # or keep it simple and decode everything that looks like an escape
            # and then decode the whole sequence as CP1251.
            # But here we replace one by one.
            return bytes([byte_val]).decode('cp1251')
        except:
            return hex_seq

    # This is a bit tricky because re.sub works on strings.
    # We'll use a more robust way to handle sequences of these.
    
    # First, find all sequences of \xHH and \\xHH
    # We want to group adjacent escapes to decode them together properly if they form a multi-byte char (though CP1251 is single byte)
    
    # Actually, CP1251 is single-byte, so we can replace one by one.
    
    # We need to handle the backslashes carefully.
    # If the file has \\xHH, it means the string in Python is literally backslash, backslash, x, H, H.
    # If it has \xHH, it's backslash, x, H, H.
    
    # Let's try a simple approach first.
    processed = text
    
    # Handle both \xHH and \\xHH cases to results in just the character
    processed = re.sub(r'\\+x([0-9a-fA-F]{2})', lambda m: bytes([int(m.group(1), 16)]).decode('cp1251', errors='replace'), text)
    return processed

with open('FBIhelper.lua', 'r', encoding='utf-8', errors='ignore') as f:
    content = f.read()

# Apply the decoding twice to catch both single and double escaped versions if they exist
decoded_content = decode_cp1251_escapes(content)

with open('FBIhelper.lua', 'w', encoding='utf-8') as f:
    f.write(decoded_content)

print("Decoding complete.")
