# Prompt: promote generated OKF

Review a generated OKF page and decide whether it can be promoted to `reviewed/`.

Checks:

- The source paths exist under `human/`.
- The summary is faithful to the source.
- The terminology matches current Apicurio Registry documentation.
- The page is small and focused.
- The `related` links are useful and not hallucinated.

When promoting:

- Move the page from `generated/` to the matching path under `reviewed/`.
- Change `status` to `reviewed`.
- Change `reviewed` to `true`.
- Add `reviewed_by` and `reviewed_at`.
- Keep source provenance.
