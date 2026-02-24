encrypt file:
  sops --encrypt --in-place {{ file }}

decrypt file:
  sops --decrypt --in-place {{ file }}

appe app env:
  just encrypt apps/{{ env }}/{{ app }}/secrets.yaml

appd app env:
  just decrypt apps/{{ env }}/{{ app }}/secrets.yaml

reconcile:
  flux reconcile ks flux-system --with-source
