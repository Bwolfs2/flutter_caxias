---
name: git-commit-with-body
description: >-
  Drafts Git commit messages with a clear subject line and a mandatory body that
  summarizes what changed (files, behavior, rationale). Use when writing commits,
  preparing git commit messages, reviewing staged changes, or when the user asks
  for "mensagem de commit", "commit com descrição", "corpo do commit", or
  "conventional commits" for this repository.
---

# Git commits — assunto + corpo obrigatório

Sempre que ajudar a **escrever ou revisar** um commit neste repositório, produza uma mensagem com **duas partes**: **assunto** (primeira linha) e **corpo** (linha em branco + texto). O **corpo é obrigatório** e deve **descrever as alterações** de forma que outra pessoa entenda o diff sem abrir todos os arquivos.

## Formato

```
<type>(<escopo opcional>): <assunto curto em imperativo>

<corpo: parágrafos e/ou lista explicando O QUE mudou e POR QUÊ quando não for óbvio>
```

- **Assunto**: até ~72 caracteres; **imperativo** (ex.: "Adiciona", "Corrige", "Refatora"); sem ponto final; em **português** se o restante do histórico do projeto estiver em PT.
- **Corpo**: não deixe vazio. Use linguagem clara, frases completas.

## O que o corpo deve conter

Inclua, quando aplicável:

1. **Resumo por área** (ex.: `lib/view`, `domain`, `data`, `test`).
2. **Comportamento**: o que o usuário ou sistema passa a fazer de diferente.
3. **Motivo** se não for evidente (bug, decisão de arquitetura, preparação para feature).
4. **Breaking changes** ou passos de migração na última linha do corpo, se houver.

Evite corpo genérico ("atualiza código", "pequenos ajustes"). Seja específico a partir do **diff** ou da lista de arquivos alterados.

## Exemplo bom

```
feat(view): adiciona página de vídeos com grade responsiva

- Inclui rota /videos e item na NavigationRail/NavigationBar.
- Carrega lista estática de youtube_videos_data.dart; abertura do link com url_launcher.
- Ajusta NavigationRail para extended + labelType compatível com o assert do Material.
```

## Exemplo ruim (não usar)

```
fix: ajustes

Alterações diversas.
```

## Integração com o fluxo do usuário

Quando o usuário pedir **só o texto** da mensagem, entregue o bloco completo (assunto + linha em branco + corpo) pronto para colar em `git commit -m` (use **heredoc** ou `-m` duplo no shell: primeira `-m` assunto, segunda `-m` corpo em várias linhas não funciona bem — preferir um único bloco com `\n` explícitos ou instruir `git commit` editor).

Quando possível, **baseie-se no output real** de `git diff --staged` ou na lista de arquivos fornecida; não invente arquivos não alterados.

## Conventional Commits (opcional)

Tipos comuns: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`. Use escopo curto (`view`, `data`, `router`) se ajudar o histórico. O **corpo continua obrigatório** mesmo com assunto perfeito.
