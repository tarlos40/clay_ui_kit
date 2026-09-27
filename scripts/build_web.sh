#!/usr/bin/env bash
set -euo pipefail

cd exemple

flutter pub get
flutter build web --release

rm -rf ../.vercel/output

mkdir -p ../.vercel/output/static

cp -R build/web/. ../.vercel/output/static/

cat > ../.vercel/output/config.json <<'EOF'
{
  "version": 3
}
EOF