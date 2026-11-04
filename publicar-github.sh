#!/bin/bash
# ============================================================
#  Publicar a Taberna Ti Maria no GitHub
#  Uso:  bash publicar-github.sh
#  O que faz: prepara o git, protege as passwords, envia tudo
#  para o GitHub. Netlify e Render atualizam-se sozinhos depois.
# ============================================================

set -e
cd "$(dirname "$0")"

# 1. O git está instalado?
if ! command -v git >/dev/null 2>&1; then
  echo "❌ O git não está instalado. Instale em https://git-scm.com e volte a correr."
  exit 1
fi

# 2. URL do repositório (só pergunta se ainda não estiver configurado)
if git remote get-url origin >/dev/null 2>&1; then
  REPO_URL=$(git remote get-url origin | sed -E 's#https://[^@]+@#https://#')
  echo "📦 Repositório: $REPO_URL"
else
  read -p "URL do repositório GitHub (ex: https://github.com/o-seu-user/taberna-ti-maria.git): " REPO_URL
fi

# 3. Token de acesso (não fica guardado em lado nenhum)
read -s -p "🔑 Cole o seu Personal Access Token do GitHub e prima Enter (não aparece enquanto escreve): " GH_TOKEN
echo

# 4. Iniciar git se necessário e ligar o repositório
[ -d .git ] || git init -b main
git remote remove origin 2>/dev/null || true
git remote add origin "https://${GH_TOKEN}@${REPO_URL#https://}"

# 5. SEGURANÇA: garantir que as passwords NÃO vão para o GitHub
git rm -r --cached --ignore-unmatch backend/.env frontend/.env >/dev/null 2>&1 || true

# 6. Juntar tudo e publicar
git add -A
git commit -m "Atualização do site $(date '+%d/%m/%Y %H:%M')" || echo "ℹ️  Não havia alterações novas."
git push -u origin main

# 7. Limpar o token da configuração local
git remote set-url origin "$REPO_URL"

echo ""
echo "✅ Publicado no GitHub!"
echo "   Se a Netlify e o Render já estiverem ligados a este repositório,"
echo "   o site e o backend atualizam-se automaticamente em 2-3 minutos."
