# Secret Squares

An Everyday Cool workshop by Steven Powell. Make real QR codes, investigate information, and share an invented secret. Free, portable, and built for curious kids and adults.

[Open project on GitHub](https://github.com/caeled/secret-squares) · [Download the complete ZIP](https://github.com/caeled/secret-squares/archive/refs/heads/main.zip)

## Start

Open **index.html** in a modern browser, or double-click **Launch.cmd** on Windows. Keep the complete folder together. No installation, account, API key, external font, server upload, or framework is needed for the core workshop.

Cryptography and packet checksums need Web Crypto. Modern browsers may allow it for local files; if yours does not, run **Serve.cmd**, which uses Python 3 already installed to serve only this folder at localhost:8003. A hosted copy must use HTTPS. Do not disable browser security settings. Close the server window to stop it.

## Eight rooms

1. **Make a code:** messages, URLs, Unicode, four correction levels, three dark inks, downloadable SVG/PNG, destination preview, and local image decoding.
2. **Inside the squares:** actual structural reservation map, finder/timing/format/alignment regions, all eight masks, and the encoding pipeline. Colored anatomy views are diagrams; plain views scan.
3. **Damage lab:** cover actual modules and test recovery with a real local QR decoder. Compare locations and correction levels without pretending image-area coverage has a guaranteed threshold.
4. **Bytes & packing:** code points, UTF-8, binary bytes, real gzip, and base64url overhead. Gzip is measured separately; ordinary studio codes do not automatically compress text.
5. **Secret messages:** AES-256-GCM with fresh random nonces and random shared keys; hybrid RSA-OAEP/SHA-256 public-key experiments. Export/import receiving keys to try two devices. Public QR codes never include private/shared secret keys.
6. **Transfer station:** custom numbered text packets with a whole-message SHA-256 checksum, reverse ordering, duplicate handling, and missing-piece detection. Not QR Structured Append.
7. **Field missions:** nine experiments and a downloadable printable treasure-hunt sheet.
8. **Go deeper:** primary sources, portable guide, scientific notes, and licensing.

## Compatibility

The QR studio and local jsQR reader work offline. For other phones, scan the generated code at a suitable size with its white border visible. Emoji codes declare UTF-8 with ECI 26; support differs between scanners. Downloads require browser download permissions. Uploaded images are decoded locally and never uploaded to a server. The reader accepts PNG, JPEG, and WebP, up to 8 MB; crop unusually large images first.

Web Crypto requires browser support and a secure context. Gzip requires CompressionStream. If either is unavailable, that bench reports the limitation; other benches remain available. The modern JavaScript QR build targets current browsers. No camera permission is requested: scanning here uses image uploads or the generated canvas.

## Privacy and learning

No analytics, telemetry, external scripts, automatic network calls, or automatic secret persistence. Secret keys and messages live in page memory until cleared/refreshed. Downloads are explicit and remain on your device. Exported secret-key files are **unencrypted**. Clearing page fields cannot guarantee secure erasure of browser memory or delete downloads.

Use made-up messages for cryptography experiments. Established algorithms do not make this an audited secure messaging product. The workshop does not authenticate senders, verify a recipient’s identity automatically, protect an already-compromised device, or hide metadata. Confirm public-key fingerprints separately through a trusted channel. See **SCIENCE.md**.

## Teach it

Try a 45-minute session: make and scan a clue (10 minutes), inspect the pattern and damage it (10), compare bytes and gzip (10), then exchange an encrypted practice message (15). For younger learners, stop after the clue and damage experiment. For advanced learners, inspect the readable source and try a two-device public-key exchange.

## Verify and package

With Node.js and Python installed:

```
node --test tests/core.test.cjs
python tests/check-package.py
```

Run **tools/Build-Package.ps1** to rebuild the USB ZIP. No runtime dependencies beyond your browser; Node and Python are development/test conveniences. Both QR libraries are bundled. Source TypeScript is retained, but a build is not required.

## Licenses

Original code/helpers: MIT, copyright Steven Powell 2026. Original educational content: CC BY 4.0. Project Nayuki’s QR encoder: MIT. jsQR: Apache 2.0. Keep applicable notices when sharing; see **THIRD-PARTY.md** and vendor license files. External research pages retain their own terms.
