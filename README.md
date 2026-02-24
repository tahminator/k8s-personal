# `k8s-personal`

Pre-commit hook to ensure that secrets files are not committed when unencrypted.

```bash
cat <<'EOF' > .git/hooks/pre-commit
#!/bin/bash
# Get a list of all secret.yaml and secrets.yaml files staged for commit
FILES=$(git diff --cached --name-only | grep -E 'secret(s)?\.yaml$')
EXIT_CODE=0
for FILE in $FILES; do
    if [ -f "$FILE" ]; then
        if ! grep -q "sops:" "$FILE"; then
            echo "--------------------------------------------------------"
            echo "ERROR: Unencrypted secret file detected: $FILE"
            echo "Please encrypt this file using SOPS before committing."
            echo "--------------------------------------------------------"
            EXIT_CODE=1
        fi
    fi
done
exit $EXIT_CODE
EOF
chmod +x .git/hooks/pre-commit
```
