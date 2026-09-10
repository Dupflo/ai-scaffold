# ai-scaffold — Plugin d'apprentissage adaptatif du dev avec IA

> Nom : **ai-scaffold** (décidé le 2026-09-10) — échafaudage (dev) + étayage pédagogique (Bruner)

## Pitch

**« The place where "I don't know" makes sense. »**

Les gens n'ont plus peur de se lancer dans le code avec l'IA — ils ont peur de ne rien comprendre à ce qui se passe. Il leur manque un harnais pour apprendre pas à pas, *avec leur propre projet* comme fil conducteur.

Ce plugin adapte l'agent IA au niveau réel de l'utilisateur : d'un agent classique pour un dev confirmé jusqu'à un mentor qui enseigne à quelqu'un qui n'a jamais écrit une ligne de code.

**Tu n'es pas à l'école où on t'impose une façon d'apprendre — c'est l'apprentissage qui s'adapte à toi.**

## Persona de référence

Un·e UX designer de métier qui veut créer sa webapp :
- n'a jamais touché une ligne de JavaScript
- connaît le terme « responsive » mais ne sait pas écrire de CSS
- comprend les produits, pas les stacks

Objectif de réussite : ce·tte designer ship sa webapp **et** comprend ce qu'il/elle a construit.

## Principes

1. **Project-first learning** — on n'apprend pas des chapitres, on apprend ce dont le projet a besoin, au moment où il en a besoin.
2. **Adapté au niveau réel** — pas un cursus imposé ; le profil pilote la pédagogie.
3. **« Je ne sais pas » est une donnée d'entrée** — pas une honte. Le plugin en fait un point de départ.
4. **L'IA code avec toi, pas à ta place** — le curseur autonomie/enseignement varie selon le niveau.

## Parcours utilisateur

### 1. Setup global (une fois)

- **Métier / niveau d'études** — proxy de départ puissant (un dev junior ≠ un maçon, les analogies et le vocabulaire changent).
- **Rapport au code** — jamais touché / bidouillé / junior / confirmé.
- **Capacité de focus** — « combien de temps peux-tu rester concentré·e par jour sur ce projet ? » (cf. Deep Work) → calibre la taille des sessions et des leçons.
- **Préférences pédagogiques** — ⚠️ voir [Points de vigilance](#points-de-vigilance) sur le mythe VAK. Questions réellement utiles :
  - exemple d'abord ou concept d'abord ?
  - tolérance à l'erreur (essai-erreur vs guidage serré) ?
  - besoin d'analogies avec son métier ?
- **Opt-in télémétrie** :
  - Oui
  - Non
  - C'est quoi la télémétrie ? → explication, puis on repose la question

### 2. Profil par projet (affinement)

- Objectif du projet, en langage utilisateur.
- **Niveau sur chaque techno requise** — auto-évalué puis vérifié par 2-3 micro-questions (les gens se sur/sous-estiment).
- **Choix de stack** : un projet est réalisable avec plusieurs technos, mais un débutant ne peut pas choisir entre 5 frameworks. → Le plugin **propose une stack par défaut justifiée en 3 phrases**, avec « pourquoi pas les alternatives » en une ligne chacune. Le confirmé peut overrider.
- Génération d'un **curriculum lié au plan du projet** : chaque étape du projet = une leçon. Le cours avance en même temps que le code.
- **Decision Ledger** activé dès le départ.

### 3. Boucle de travail (le cœur)

Mode d'exécution gradué selon le niveau :

| Niveau | Comportement de l'agent |
|---|---|
| 0 — jamais codé | Explique le concept → code en commentant → fait reformuler à l'utilisateur avant de continuer |
| 1 — bidouilleur | Propose des trous à remplir, des mini-exercices sur le code du projet |
| 2 — junior | Code normalement mais justifie chaque décision structurante, quiz ponctuels |
| 3 — confirmé | Agent classique, ledger optionnel |

- **Spec-first** quand applicable : apprendre en même temps le pilotage de projet par l'IA (cf. killer-saas, article specs).
- **Decision Ledger** : chaque décision coûteuse à inverser est expliquée au niveau de l'utilisateur, qui doit pouvoir la défendre.

#### Intégration de decision-ledger (décidé)

`decision-ledger` reste un **package indépendant** ([Dupflo/decision-ledger](https://github.com/Dupflo/decision-ledger), installé via son `install.sh` dans `~/.claude/skills` avec symlinks), jamais copié dans ai-scaffold :

- **Délégation au runtime** : les skills d'ai-scaffold invoquent le skill `ledger` installé sur la machine. Il n'y a qu'une seule copie, partagée — toute mise à jour de decision-ledger (re-run de son install.sh) profite immédiatement à ai-scaffold, sans re-release.
- **Auto-install de la dépendance** : comme le repo est sur GitHub, l'installeur/setup d'ai-scaffold peut chaîner l'install.sh de decision-ledger si le skill `ledger` est absent — modèle package manager. ⚠️ Tant que le repo est privé, ça exige `gh` authentifié ; à passer en public avant de distribuer ai-scaffold à d'autres.
- **Compatibilité de versions** : ajouter un tag git / fichier VERSION à decision-ledger pour qu'ai-scaffold puisse vérifier une version minimale et proposer la mise à jour.
- **Wrapper fin** côté ai-scaffold : charge `/ledger` puis ajoute la couche pédagogique (questions de défense adaptées au niveau, vocabulaire métier). decision-ledger n'est jamais modifié.
- À ne pas faire : vendorer (copie ou git submodule) — deux copies installées créeraient des collisions de noms de skills et les mises à jour ne se propageraient plus.
- **Révision espacée** (v2) : re-questionner sur les notions vues il y a N jours.

## Composants techniques (plugin Claude Code)

- **Skills/commands** — convention de nommage : préfixe `as-` (ai-scaffold) :
  - `/as-setup` — point d'entrée : vérifie si un profil global existe (sinon lance le questionnaire) et contrôle les dépendances (decision-ledger installé ?)
  - `/as-profile` — consulter / éditer le profil (global et projet)
  - `/as-project` — profil par projet + stack proposée + curriculum
  - `/as-lesson` — la leçon liée à l'étape en cours
  - `/as-quiz` — rappel actif sur les notions vues
  - `/as-level` — réévaluation du niveau
  - `/as-status` — où j'en suis (projet + apprentissage)
- **Fichiers** :
  - global : `profile.md` (métier, focus, préférences)
  - par projet : `.learn/profile.md`, `.learn/curriculum.md`, `.learn/progress.md`, `.learn/ledger.md`
- **Injection** : un skill (ou output-style) qui adapte ton, densité et niveau de chaque réponse au profil.
- **RAG local dynamique** : v1 pragmatique = dossier `docs/` curé par techno avec versions pinnées + un « update checker » simple (comparaison de versions, régénération si mise à jour majeure). Vrai RAG vectoriel = v2 — coût/complexité non justifiés pour un MVP.
- **Télémétrie** (opt-in) : voir ce que les gens essaient de construire avec quel niveau, et mesurer la progression. Schéma minimal et anonyme : profil déclaré, type de projet, progression. Endpoint à définir. Penser RGPD dès le design.

## Points de vigilance

- **Le mythe des styles d'apprentissage (VAK)** : « visuel / auditif / kinesthésique » est séduisant mais la recherche montre qu'adapter l'enseignement au style déclaré n'améliore pas l'apprentissage (Pashler et al., 2008). Les leviers qui marchent : connaissances préalables, exemples travaillés, rappel actif (quiz), charge cognitive, espacement. → Ancrer la pédagogie sur la **zone proximale de développement** (Vygotsky) et l'**étayage** (Bruner) plutôt que sur le VAK. Le doc de l'Université de Lorraine couvre ces théories.
- **Illusion de compétence** : le risque n°1 du dev assisté par IA — l'IA fait, l'utilisateur croit savoir. C'est exactement ce que contrent la reformulation, les quiz et le ledger. C'est le différenciateur du produit.
- **Scope creep** : profiling + moteur pédago + RAG + télémétrie + spaced repetition = quatre produits. Le MVP doit être brutal.

## MVP proposé

1. `/setup-profile` — 5 à 7 questions, écrit `profile.md`
2. Profil par projet + stack proposée et justifiée
3. Mode enseignement gradué (au moins 3 niveaux) via skill d'injection
4. Curriculum lié au projet + `progress.md`

Hors MVP (v2+) : RAG local, télémétrie, révision espacée, réévaluation automatique du niveau.

## Nom

**ai-scaffold** (décidé le 2026-09-10). Double sens : échafaudage (dev) et étayage pédagogique (Bruner). Le préfixe `ai-` lève l'ambiguïté avec les outils de scaffolding classiques (yeoman, `rails scaffold`…). Skills préfixés `as-` : `/as-profile`, `/as-project`, `/as-lesson`, etc. (décidé le 2026-09-10).

Écartés : `zpd` (opaque), `dojo`/`sensei` (déjà très pris), `training-wheels` (connote uniquement débutant), `ai-dev-level-0` (enferme dans le niveau 0).

## Sources

- [Les théories de l'apprentissage — Université de Lorraine](https://sup.univ-lorraine.fr/wp-content/uploads/2022/01/FS_les_theories_de_apprentissage.pdf)
- The Structure of Magic — Bandler & Grinder (Harambee University Digital Library) — pour les questions de setup
- [Deep Work — Cal Newport](https://cpcglobal.org/publications/Deep%20Work.pdf) — calibrage du focus
- [killer-saas — MikeCodeur](https://github.com/MikeCodeur/killer-saas) — pipeline spec-first
- [Have you ever asked yourself if you write good specs?](https://medium.com/@pinkert/have-you-ever-asked-yourself-if-you-write-good-specs-3c12246ff2bc)
- Pashler, McDaniel, Rohrer & Bjork (2008), *Learning Styles: Concepts and Evidence* — le débunk du VAK
