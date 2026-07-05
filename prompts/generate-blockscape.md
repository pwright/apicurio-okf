# Prompt: generate Blockscape from reviewed OKF

Use reviewed OKF pages as source material and generate Blockscape JSON.

Rules:

- Output valid Blockscape JSON.
- Use schema shape: `{ id, title, abstract?, categories:[{id,title,items:[{id,name,deps?:[],logo?,external?:url,color?,stage?:1-4,...}}]}] }`.
- Use `stage` only when explicitly justified by the source material.
- When `stage` is absent, order items in a category from less mature/custom to more mature/commodity.
- If a docs/code fit is uncertain, keep the item but set `color` to `#0000ff`.
- Preserve source references in item metadata where useful.
- links to generated content should use pattern from justfile and no .md ext like https://pwright.github.io/apicurio-okf/generated/concepts/schema-registry
