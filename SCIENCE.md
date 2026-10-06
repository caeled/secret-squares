# Secret Squares: science, formats, and limits

## A QR code is an encoding

QR Code Model 2 has versions 1–40, with side length 17 + 4 × version modules (21–177). The quiet zone is four modules on every side. Function patterns reserve cells; the remaining region carries encoded message bits, interleaved error-correction bits, and remainder bits. Our encoder is Project Nayuki’s implementation. We show the actual reservation map from the same algorithm without altering the generated code.

The diagram groups finder patterns with separators/nearby fixed structural cells; timing cells are row/column 6 outside finder regions; format cells are near row/column 8; the remaining reserved cells include alignment and version regions. These are learning groups, not a replacement for the specification’s individual bit numbering.

Numeric mode uses 10 bits per complete group of three digits; final groups have different lengths. Alphanumeric mode uses 11 bits per complete pair from the 45-character alphabet. Byte mode carries bytes. UTF-8 needs a variable number of bytes per code point. Our Unicode codes add ECI 26, indicating UTF-8. The encoder selects numeric, alphanumeric, or UTF-8 byte mode for the whole string; it does not perform full mixed-mode optimal segmentation. Correction level is exactly the selected level (automatic boosting is disabled).

Eight masks avoid hard-to-read module arrangements. The chosen mask is described by protected format information. Readers reverse masking; it provides no secrecy. Version information is present from version 7.

Sources: [DENSO WAVE versions](https://www.qrcode.com/en/about/version.html), [Project Nayuki library](https://www.nayuki.io/page/qr-code-generator-library), [encoding step by step](https://www.nayuki.io/page/creating-a-qr-code-step-by-step), [Unicode encoding FAQ](https://www.unicode.org/faq/utf_bom.html).

## Recovery is not an area promise

Reed–Solomon correction operates on codewords within blocks. DENSO WAVE’s familiar L/M/Q/H approximations are about 7/15/25/30 percent of codewords, not an unconditional percentage of image area. A patch may damage structural marks, concentrate errors in one block, or prevent symbol detection. Our lab counts modules covered and changed but does not convert that into a theoretical guaranteed recovery limit. It uses the bundled jsQR decoder to test the actual rendered image. Another scanner can have different detection behavior.

Sources: [DENSO WAVE error correction](https://www.qrcode.com/en/about/error_correction.html), [jsQR source](https://github.com/cozmo/jsQR).

## Compression is a separate operation

The packing bench measures a real browser gzip stream, including gzip headers/trailer, using CompressionStream. It also reports the length of base64url text representing those bytes. Base64url is an encoding, not compression; it usually adds approximately one-third to binary length, excluding removed padding. Tiny inputs may grow under gzip. No gzip data is silently put in a studio QR: ordinary readers would need a format and decompressor to interpret it.

Code-point counts use JavaScript iteration; byte counts use TextEncoder UTF-8. A user-perceived character can contain multiple code points. JavaScript string length counts UTF-16 code units. The bit viewer displays UTF-8 bytes; those are not a claim that QR payload bits sit at those exact visual coordinates.

Source: [CompressionStream](https://developer.mozilla.org/en-US/docs/Web/API/CompressionStream).

## Public patterns and private meaning

Web Crypto supplies the implementation. Shared-key encryption uses a fresh cryptographically random 32-byte AES key and 12-byte nonce. AES-GCM uses the browser’s default 128-bit authentication tag. Additional authenticated data is the UTF-8 string `Secret Squares v1`. The nonce is public and is included in the envelope; the AES key is not.

Public-key encryption is hybrid: each message receives a fresh AES key; RSA-OAEP (2048-bit, SHA-256) wraps that key. RSA does not directly encrypt the long message. Public SPKI key material is shareable. Private PKCS#8 material remains in memory unless explicitly downloaded and can be imported on a receiving device. Both exported secret/private key files are unencrypted. Key generation and encryption use crypto.getRandomValues/Web Crypto, never Math.random.

**SSQ1 format:** prefix `SSQ1:` and JSON `{v:1,m:"shared"|"public",i:<base64url nonce>,c:<base64url ciphertext+tag>,w?:<base64url wrapped AES key>}`. Public keys use `SSPUB1:` plus base64url SPKI; private keys use `SSPRIVATE1:` plus base64url PKCS#8. These are custom teaching formats, not OpenPGP, JWE, or a general messaging protocol. Length and shape checks precede decryption. Plaintext is displayed only after successful tag verification.

A shared secret allows either holder to decrypt and create messages. Anyone knowing a receiving public key can send encrypted messages; this does **not** authenticate the sender. Check the full SHA-256 fingerprint of the public SPKI bytes through a trusted channel to help confirm the intended key. This check does not prove identity by itself. The envelope header is not a comprehensive authenticated protocol transcript. The workshop has not received an independent security audit, provides no forward secrecy or revocation system, and is for invented practice messages.

Cryptography cannot protect plaintext on a compromised device or prevent someone from copying a revealed key. Encryption exposes message existence, approximate length, and sharing context. No secret is automatically stored, uploaded, or included in its encrypted QR. Clearing UI fields does not guarantee secure memory erasure. No claim is made about deleting browser caches or downloads.

Sources: [MDN Web Crypto encryption](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/encrypt), [decryption](https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/decrypt), [Web Cryptography specification](https://www.w3.org/TR/WebCryptoAPI/).

## Optical packets

We split at most 4096 UTF-8 bytes into chunks of at most 220 bytes. Each QR contains text `SSP1:` plus JSON `{g:<SHA-256 hex of complete bytes>,i:<1-based index>,n:<total>,b:<base64url chunk>}`. Up to 19 packets are needed. Assembly checks group and total, validates indices, handles identical duplicates, rejects conflicting duplicates, identifies missing pieces, joins bytes in order, and verifies the whole-message digest before UTF-8 decoding. Unicode characters may cross packet boundaries because bytes are joined first.

This is not QR Structured Append and does not implement automatic camera sequencing. A QR reader reveals each packet as text; the receiving bench performs reassembly. The checksum detects inconsistency but is not authentication: an attacker can change the entire message and calculate a new checksum. Packets are not encrypted. Transmission uses light from a display or print to a camera; decoding the contained URL does not load its website unless the user then opens it.

## Trust before navigation

URLs are parsed with the browser URL API. Only http/https destinations receive an explicit opening link; no decoded content opens automatically. A domain mentioned in a path is not the host. HTTPS protects transport but does not establish that a site is trustworthy. No URL reputation service is used, and destination preview is not a security certification.

Source: [FTC QR code guidance](https://consumer.ftc.gov/consumer-alerts/2023/12/scammers-hide-harmful-links-qr-codes-steal-your-information).

## ASL discovery: language is more than encoding

The optional mini-lesson introduces ASL fingerspelling using real educator references. ASL has its own grammar and community history; it is not a universal secret code, and spelling an English sentence is not the same as translating it into ASL. Still charts cannot fully teach motion, so a real demonstration accompanies the chart. The closing invitation is original written English, not a claim to have generated an ASL translation. Learn further with Deaf educators.

Sources: [NIDCD introduction](https://www.nidcd.nih.gov/health/american-sign-language), [ASL University alphabet](https://www.lifeprint.com/asl101/fingerspelling/abc.htm), [Gallaudet ASL](https://gallaudet.edu/asl/). Media permissions are in THIRD-PARTY.md.
