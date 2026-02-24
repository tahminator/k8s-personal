# `k8s-personal`

Run this command on your VPS through SSH:

```bash
curl -sfL https://get.k3s.io | sh -

# double check that it worked
sudo k3s kubectl get node
```

To copy the kubeconfig from your single node VPS to your local machine, run this:

```bash
# replace <YOUR_VPS_IP>
mkdir -p ./.kube/
scp root@<YOUR_VPS_IP>:/etc/rancher/k3s/k3s.yaml ./.kube/config-k3s

# replace all mentions of 127.0.0.1 with <YOUR_VPS_IP>
sed -i '' 's/127.0.0.1/<YOUR_IP_HERE>/g' ./.kube/config-k3s
```

Ensure that you have `direnv` installed so it will automatically export `KUBECONFIG`
to your environment when you're inside of this repo (see [.envrc](./.envrc))

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
            echo "Please encrypt this file by running \`just encrypt $FILE\`,"
            echo "then run \`git add $FILE\`."
            echo "--------------------------------------------------------"
            EXIT_CODE=1
        fi
    fi
done
exit $EXIT_CODE
EOF
chmod +x .git/hooks/pre-commit
```
