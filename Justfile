encrypt file:
  sops --encrypt --in-place {{ file }}

decrypt file:
  sops --decrypt --in-place {{ file }}

reconcile:
  flux reconcile ks flux-system --with-source
