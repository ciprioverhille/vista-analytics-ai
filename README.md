# Vista Analytics

Site de Vista Analytics : analyse vidéo pour les staffs de football.

- `index.html` : la page (HTML, CSS et JS inclus, aucune compilation).
- `logo.svg` : le logo, aussi utilisé comme icône d'onglet.

## Hébergement

Site statique déployé par Vercel à chaque push sur `main`.

## Liste d'attente

Le formulaire de demande d'accès (e-mail, club, fonction) écrit dans la table `waitlist` du projet Supabase `vista-analytics-ai` (région Paris).
Les règles RLS autorisent uniquement l'insertion depuis le site : la liste se consulte dans
Supabase → Table Editor → `waitlist`.
