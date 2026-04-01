#!/usr/bin/env python3
import random, xml.etree.ElementTree as ET, os, sys

RUMDA_DIR = os.path.expanduser("~/.config/rumda")
SVG_FILE = os.path.join(RUMDA_DIR, "light-config/rofi/calligraphy/bg.svg")
OUTPUT_FILE = os.path.join(RUMDA_DIR, "light-config/rofi/calligraphy/bg_new.svg")
POETRY_FILE = os.path.join(RUMDA_DIR, "light-config/rofi/calligraphy/quotes.txt")

if len(sys.argv) != 3:
    print("Usage: rofi_poetry.py <text_color> <bg_color>")
    sys.exit(1)

text_color = sys.argv[1]
bg_color = sys.argv[2]

with open(POETRY_FILE, "r", encoding="utf-8") as f:
    lines = [l.strip() for l in f if l.strip()]

quotes = [lines[i:i+2] for i in range(0, len(lines), 2)]
line1, line2 = random.choice(quotes)

tree = ET.parse(SVG_FILE)
root = tree.getroot()
ns = {"svg": "http://www.w3.org/2000/svg"}

rect = root.find(".//svg:rect", ns)
if rect is not None:
    style = rect.get("style", "")
    style = ";".join(
        f"fill:{bg_color}" if p.strip().startswith("fill:") else p
        for p in style.split(";")
    )
    rect.set("style", style)

tspans = root.findall(".//svg:tspan", ns)
if len(tspans) < 2:
    raise RuntimeError("SVG does not have 2 tspans")

for tspan in tspans:
    style = tspan.get("style", "")
    parts = style.split(";")
    new_parts = []
    for p in parts:
        if p.strip().startswith("fill:"):
            new_parts.append(f"fill:{text_color}")
        elif p.strip().startswith("stroke:"):
            new_parts.append(f"stroke:{text_color}")
        else:
            new_parts.append(p)
    tspan.set("style", ";".join(new_parts))

tspans[0].text = line1
tspans[1].text = line2

tree.write(OUTPUT_FILE, encoding="utf-8", xml_declaration=True)
print(f"Saved {OUTPUT_FILE} with text='{text_color}' bg='{bg_color}'")
