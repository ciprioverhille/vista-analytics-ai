# Ciprio

Site de Ciprio (en anglais) : analyse vidéo pour les staffs de football.

## Structure

- `index.html` : page d'accueil (HTML, CSS et JS inclus).
- `assets/site.css` : styles communs des autres pages.
- `src/pages/*.html` et `src/pages/blog/*.html` : contenu des pages secondaires (About, Contact, Blog, pages légales, 404).
- `src/partials/` : en-tête, menu et pied de page communs.
- `tools/build-pages.sh` : génère les pages HTML à partir de `src/`. À relancer après chaque modification de `src/` :
  `bash tools/build-pages.sh`
- `sitemap.xml`, `robots.txt` : référencement. Ajouter chaque nouvel article au sitemap.
- `logo.svg` : logo, aussi utilisé comme icône d'onglet.

## Hébergement

Site statique déployé par Vercel (projet `ciprio`, https://ciprio.ai) à chaque push sur `main`.
`vercel.json` active les adresses sans `.html` (`/about`, `/blog/...`).

## Données (Supabase, projet `vista-analytics-ai`, région Paris)

- `waitlist` : demandes d'accès (e-mail, club, fonction).
- `contact_messages` : messages du formulaire de contact.

Les règles RLS autorisent uniquement l'insertion depuis le site. Consultation : Supabase → Table Editor.
