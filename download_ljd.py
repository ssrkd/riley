import urllib.request
import zipfile
import io
import os

url = "https://github.com/AzurLaneTools/ljd/archive/refs/heads/main.zip"
print(f"Downloading from {url}...")
with urllib.request.urlopen(url) as response:
    content = response.read()

with zipfile.ZipFile(io.BytesIO(content)) as z:
    z.extractall("/Users/serik08/Documents/FBI/")

# Find the extracted directory name
extracted_dir = next(d for d in os.listdir("/Users/serik08/Documents/FBI/") if d.startswith("ljd-main") or d.startswith("ljd-master"))
os.rename(os.path.join("/Users/serik08/Documents/FBI/", extracted_dir), "/Users/serik08/Documents/FBI/ljd_tool")
print("Successfully extracted to ljd_tool")
