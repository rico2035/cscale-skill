# /cscale Image Prompt Library

The 8-image batch generated per report via Higgsfield `nano_banana_2`. Default resolution is 1k. (Saves cost. Quality is sufficient for a strategy report.)

---

## CLI syntax

```bash
higgsfield generate create nano_banana_2 \
  --aspect_ratio <ratio> \
  --resolution 1k \
  --prompt "<full prompt>" \
  --output <output-path>
```

Aspect ratios used in this report:

- **16:9** for hero images at the top of major sections
- **4:3** for inline supporting images inside bonus blocks
- **1:1** for small accent images (rare)

Resolution stays at `1k` unless explicitly raised to 2k for a print-quality output.

---

## Required image batch

Per report, the skill generates these 8 images. All saved to `public/images/cscale/<slug>/`.

| Filename | Aspect | Section | Purpose |
|---|---|---|---|
| `hero-thesis.png` | 16:9 | Section 5. 18-month thesis | Hero image right of the thesis paragraph |
| `peer-tier-band.png` | 16:9 | Section 4. Competitor map peer band | Visual cue for the peer altitude |
| `mid-tier-band.png` | 16:9 | Section 4. Competitor map mid band | Visual cue for the mid altitude |
| `aspirational-tier-band.png` | 16:9 | Section 4. Competitor map aspirational band | Visual cue for the aspirational altitude |
| `ai-overlay-hero.png` | 16:9 | Section 7. AI optimization layer | Right of the AI overlay matrix |
| `pivot-scenarios.png` | 4:3 | Section 8. Bonus 1. Pivot scenarios | Inside the bonus block |
| `expansion-products.png` | 4:3 | Section 9. Bonus 2. Expansion products | Inside the bonus block |
| `investor-targets.png` | 4:3 | Section 11. Bonus 4. Investor targets | Inside the bonus block |

---

## Brand-aware prompt rules

Every Higgsfield prompt for cscale reports must include these anchors:

- **Color palette anchor.** "warm gradient palette of coral, hot pink, magenta, with cream and warm-paper backgrounds"
- **Style anchor.** "editorial photography, soft natural light, magazine-quality, light and airy, shallow depth of field"
- **Negative prompts.** "no dark navy, no cyan, no blue gradients, no stock-photo cliches, no fake-looking AI faces, no text overlays, no logos, no watermarks"
- **Format anchor.** "1024x576 16:9 wide composition" (or whatever ratio applies)

Always append the color, style, and negative anchors to every prompt below.

---

## Vertical-aware hero scene templates

The hero-thesis image is the only image that varies by the target company's vertical. Substitute the scene phrase based on `vertical` from the intake JSON.

| Vertical | Scene phrase |
|---|---|
| medspa | "serene beauty treatment room at golden hour, warm coral and magenta lighting on white linen, soft focus on a single rose-gold tool tray" |
| dental | "bright modern dental clinic reception, white oak and brushed brass details, sunlit warm-paper walls, single fresh peony in a ceramic vase" |
| HVAC | "clean white service van at a residential driveway at sunrise, technician's silhouette holding a tablet, soft pink and coral sky" |
| legal | "warm-toned attorney's office library, leather and walnut, single brass desk lamp casting pink-gold light on an open contract" |
| real estate | "open-plan modern home interior at golden hour, magenta sunset through floor-to-ceiling windows, single warm-paper sofa" |
| home services | "freshly mowed front yard at golden hour, modern home facade with cream stucco, warm pink sky" |
| other | "warm minimal workspace at golden hour, magenta light raking across a desk with a single fresh flower" |

---

## Full prompt library

### 1. hero-thesis.png (16:9)

```
{{VERTICAL_SCENE_PHRASE}}. Editorial photography, soft natural light, magazine-quality, light and airy, shallow depth of field. Warm gradient palette of coral, hot pink, magenta, with cream and warm-paper backgrounds. No dark navy, no cyan, no blue gradients, no stock-photo cliches, no fake-looking AI faces, no text overlays, no logos, no watermarks. 1024x576 16:9 wide composition.
```

### 2. peer-tier-band.png (16:9)

```
Ground-level perspective looking up a gentle hill at dawn, mist clearing, soft warm light, sense of beginning. Subtle coral and magenta gradient in the sky, cream foreground grass. Abstract and metaphorical, no human figures. Editorial photography, soft natural light, magazine-quality, light and airy. Warm gradient palette of coral, hot pink, magenta, with cream and warm-paper backgrounds. No dark navy, no cyan, no blue gradients, no text overlays. 1024x576 16:9 wide composition.
```

### 3. mid-tier-band.png (16:9)

```
Mid-altitude aerial perspective from a hillside looking out over a soft valley at golden hour, sense of progress and visibility. Warm coral, hot pink, and magenta sky, cream and warm-paper land below, no urban density. Abstract and metaphorical, no human figures. Editorial photography, soft natural light, magazine-quality. Warm gradient palette of coral, hot pink, magenta, with cream and warm-paper backgrounds. No dark navy, no cyan, no blue gradients, no text overlays. 1024x576 16:9 wide composition.
```

### 4. aspirational-tier-band.png (16:9)

```
High-altitude aerial perspective from above the clouds at sunset, vast cloudscape lit by warm sun, sense of arrival and altitude. Magenta and hot pink in the upper sky, coral and warm-paper clouds below, cream highlights. Abstract and metaphorical, no human figures, no aircraft. Editorial photography, soft natural light, magazine-quality. Warm gradient palette of coral, hot pink, magenta, with cream and warm-paper backgrounds. No dark navy, no cyan, no blue gradients, no text overlays. 1024x576 16:9 wide composition.
```

### 5. ai-overlay-hero.png (16:9)

```
Abstract visualization of a human hand and a glowing geometric form in soft handoff, warm light passing between them, sense of collaboration not replacement. Coral light on the human hand, magenta glow on the form, cream and warm-paper background. Editorial photography, soft natural light, magazine-quality, light and airy. Warm gradient palette of coral, hot pink, magenta, with cream and warm-paper backgrounds. No dark navy, no cyan, no blue gradients, no fake-looking AI faces, no text overlays, no robotic clichés. 1024x576 16:9 wide composition.
```

### 6. pivot-scenarios.png (4:3)

```
Single dirt path in a soft meadow at golden hour, splitting cleanly into three diverging paths up ahead, each glowing with a different warm tint of coral, pink, and magenta. Aerial view from low angle. Sense of optionality, not loss. No human figures, no signage. Editorial photography, soft natural light, magazine-quality. Warm gradient palette of coral, hot pink, magenta, with cream and warm-paper backgrounds. No dark navy, no cyan, no blue gradients, no text overlays. 1024x768 4:3 composition.
```

### 7. expansion-products.png (4:3)

```
Five fresh peonies of different sizes and shades arranged in soft sunlight on a warm-paper surface, smallest in front, largest in back, suggesting a growing product line. Coral, pink, and magenta blooms with cream surface. Editorial photography, soft natural light, magazine-quality, light and airy, shallow depth of field. Warm gradient palette of coral, hot pink, magenta, with cream and warm-paper backgrounds. No dark navy, no cyan, no blue gradients, no text overlays, no people. 1024x768 4:3 composition.
```

### 8. investor-targets.png (4:3)

```
Small group of warm-toned brass and rose-gold geometric shapes arranged on a cream surface at golden hour, soft shadows, sense of careful selection. Coral, magenta, and warm-paper lighting. No chess pieces, no money imagery, no clichés. Editorial photography, soft natural light, magazine-quality. Warm gradient palette of coral, hot pink, magenta, with cream and warm-paper backgrounds. No dark navy, no cyan, no blue gradients, no text overlays. 1024x768 4:3 composition.
```

---

## Storage convention

All images for a given report live at:

```
public/images/cscale/<slug>/
  hero-thesis.png
  peer-tier-band.png
  mid-tier-band.png
  aspirational-tier-band.png
  ai-overlay-hero.png
  pivot-scenarios.png
  expansion-products.png
  investor-targets.png
  competitors/
    <competitor-1-slug>/
      ad-001.png
      ad-002.png
      ad-003.png
    <competitor-2-slug>/
      ...
```

Reference path in HTML uses `/images/cscale/<slug>/hero-thesis.png` (no leading `public/`).

---

## Fallback when Higgsfield is unavailable

If `higgsfield generate --help` fails or auth is missing, the orchestrator sets the body class `.no-images` and adds a small cover-note line: "Visuals omitted from this run. Images can be regenerated with `npm run cscale:images <slug>`."

The CSS in `templates/report.html` is responsible for hiding image placeholders when `.no-images` is on `<body>`. Text content stands alone.

---

## Alt text rules

Every image has alt text in the format:

```
<Section name> visual: <one-line scene description>
```

Examples:

- `Peer tier band visual: ground-level perspective looking up a gentle hill at dawn with warm coral mist`
- `AI overlay visual: human hand and glowing geometric form in soft handoff under warm light`
- `Pivot scenarios visual: single dirt path splitting into three diverging paths at golden hour`

Alt text never contains the words "image of", "picture of", or "photo of". Just the scene.

---

## Quality and regeneration

Higgsfield at 1k is cheap enough to regenerate any image that misses the brand. Bias toward regenerating rather than shipping off-brand imagery. If an image comes back with any of these markers, regenerate.

- Any blue or navy in the dominant palette.
- Any visible text or watermark.
- Any human face that looks AI-generated (uncanny eyes, asymmetric features, plastic skin).
- Cliché stock-photo setups (handshakes, lightbulbs, charts on tablets).
- Dark or grim mood. The brand is light and airy.

Document each regeneration in the working folder at `runs/<slug>/image-generation-log.md` so the pattern feeds the next iteration of these prompts.
