#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
tmpdir=$(mktemp -d)
trap 'rm -rf -- "$tmpdir"' EXIT

cat > "$tmpdir/build.prop" <<'EOF'
ro.product.manufacturer=Nokia
ro.product.device=deadmau5
ro.build.version.release=13
ro.build.description=deadmau5-user 13 TKQ1.230127.002 00WW_3_230 release-keys
EOF

# Exercise the script's real property reader in an Ubuntu ripgrep build that
# deliberately has no PCRE2 support.
source <(sed -n '/^prop_value() {/,/^}/p' "$repo_root/dumpyara.sh")
PROP_FILES=("$tmpdir/build.prop")

[[ $(prop_value ro.product.manufacturer) == "Nokia" ]]
[[ $(prop_value ro.product.device) == "deadmau5" ]]
[[ $(prop_value ro.build.version.release) == "13" ]]

# A PCRE2-less ripgrep must not turn optional legacy probes into an error flood.
source <(sed -n '/^# Ubuntu.*ripgrep/,/^fi$/p' "$repo_root/dumpyara.sh")
if ! printf 'x=ok\n' | command rg -P '(?<=^x=).*' >/dev/null 2>&1; then
    probe_output=$(rg -m1 -INoP --no-messages '(?<=^ro.product.manufacturer=).*' "$tmpdir/build.prop" 2>&1 || true)
    [[ -z $probe_output ]]
fi
