from pathlib import Path
from html.parser import HTMLParser
import re

root = Path(__file__).resolve().parents[1]
class Check(HTMLParser):
    def __init__(self):
        super().__init__(); self.ids=[]; self.links=[]; self.labels=[]
    def handle_starttag(self, tag, attrs):
        a=dict(attrs)
        if 'id' in a: self.ids.append(a['id'])
        if tag=='label' and 'for' in a: self.labels.append(a['for'])
        for key in ('href','src'):
            if key in a: self.links.append(a[key])
c=Check(); c.feed((root/'index.html').read_text(encoding='utf-8'))
assert len(c.ids)==len(set(c.ids)), 'Duplicate IDs'
for label in c.labels: assert label in c.ids, label
for link in c.links:
    if link.startswith('#'): assert link[1:] in c.ids, link
    elif not re.match(r'^[a-z]+:',link): assert (root/link).is_file(), link
js=(root/'assets/app.js').read_text(encoding='utf-8')
for id in re.findall(r"\$\('([^']+)'\)",js): assert id in c.ids, id
assert '@import' not in (root/'assets/style.css').read_text(encoding='utf-8')
assert 'fetch(' not in js and 'localStorage' not in js
asl=Check(); asl.feed((root/'workshop-asl.html').read_text(encoding='utf-8'))
assert len(asl.ids)==len(set(asl.ids)), 'Duplicate ASL IDs'
for link in asl.links:
    if not re.match(r'^[a-z]+:',link): assert (root/link.split('#')[0]).is_file(), link
for id in re.findall(r"getElementById\('([^']+)'\)",(root/'assets/asl.js').read_text(encoding='utf-8')): assert id in asl.ids, id
print(f'Package verified: {len(c.ids)} unique IDs, {len(c.links)} links/assets, matching labels and script controls.')
