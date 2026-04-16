# Flutter Caxias do Sul — site institucional

Site da comunidade em **Flutter Web**, com páginas estáticas (sobre, eventos, links e vídeos do YouTube).

## Como rodar

```bash
flutter pub get
flutter run -d chrome
```

## Build para produção (web)

```bash
flutter build web --release
```

Artefatos em `build/web`. Sirva essa pasta em qualquer hospedagem estática (Firebase Hosting, Cloudflare Pages, Nginx, etc.).

### Site em um subcaminho (subpath)

Se o app não ficar na raiz do domínio (por exemplo `https://exemplo.org/flutter-cxs/`), gere o build com **`--base-href`** alinhado ao subcaminho (sempre com `/` no início e no fim):

```bash
flutter build web --release --base-href /flutter-cxs/
```

Sem isso, o carregamento de `main.dart.js` e demais assets pode falhar.

## Onde editar conteúdo

| Conteúdo | Arquivo |
|----------|---------|
| Textos institucionais e URL placeholder do Meetup | `lib/data/community_content.dart` |
| Lista de eventos | `lib/data/events_data.dart` |
| Vídeos (IDs do YouTube + títulos) | `lib/data/youtube_videos_data.dart` |
| Links sociais da página Links | `lib/pages/links_page.dart` (`kSocialLinks`) |

## Testes

```bash
flutter test
```
