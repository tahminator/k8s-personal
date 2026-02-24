encrypt file:
  sops --encrypt --in-place {{ file }}

decrypt file:
  sops --decrypt --in-place {{ file }}

flux-force-reconcile:
  flux reconcile source git flux-system
