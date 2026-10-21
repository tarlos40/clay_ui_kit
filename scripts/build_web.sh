
#!/usr/bin/env bash
set -euo pipefail

# Entrar na pasta do aplicativo Flutter Web
cd example

# Instalar dependências e gerar o build
flutter pub get
flutter build web --release

# Preparar a saída para o deploy na Vercel
rm -rf ../.vercel/output
mkdir -p ../.vercel/output/static

cp -R build/web/. ../.vercel/output/static/

# Configuração do deploy pré-compilado da Vercel
cat > ../.vercel/output/config.json <<'EOF'
{
  "version": 3
}
EOF

echo "Build preparado com sucesso!"
