# Como publicar o site no GitHub (script incluído)

O projeto traz um script que faz tudo por si: `publicar-github.sh`

## Preparação (só da primeira vez, ~5 minutos)

1. **Crie o repositório no GitHub** — github.com → **New repository**
   - Nome: `taberna-ti-maria`
   - **IMPORTANTE: escolha "Private"** (o projeto tem configurações internas)
   - Não marque "Add a README" (o projeto já tem)
2. **Crie um token de acesso** (é a "chave" que o script usa):
   - github.com → a sua foto (canto superior direito) → **Settings**
   - No fim do menu lateral: **Developer settings** → **Personal access tokens** → **Tokens (classic)**
   - **Generate new token (classic)** → nome: `publicar-site` → marque a caixa **repo** → Generate
   - **Copie o token** (começa por `ghp_...`). Só aparece uma vez!
3. **Tenha o projeto no seu computador:**
   - Opção A (mais fácil): no Emergent, use **Save → Save to GitHub** para a primeira publicação, e depois no PC faça `git clone https://github.com/o-seu-user/taberna-ti-maria.git`
   - Opção B: github.com → página do repositório → **Code → Download ZIP** → descompacte

## Publicar (da primeira vez e sempre)

1. Abra um terminal dentro da pasta do projeto
2. Corra:
   ```bash
   bash publicar-github.sh
   ```
3. Cole o URL do repositório e o token quando o script pedir
4. Pronto — o GitHub fica atualizado. Se a Netlify/Render já estiverem ligados, o site publicado atualiza-se sozinho em 2-3 minutos.

## Notas de segurança

- O script **remove automaticamente** os ficheiros `.env` (onde estão a password do admin e as chaves) do envio para o GitHub. Esses valores configuram-se diretamente no Render (ver DEPLOY-GRATIS.md, Passo 2).
- Mesmo assim, mantenha o repositório **Private**.
- O token nunca fica guardado: o script usa-o apenas naquele envio.

## Se preferir não usar terminal

Instale o **GitHub Desktop** (desktop.github.com, grátis): abra a pasta do projeto, escreva uma mensagem de commit, clique "Push". Faz o mesmo que o script, com botões.
