# Level 02 - Snowcrash

## Objectif

Trouver le mot de passe de l'utilisateur `flag02` en analysant une capture réseau.

## Solution

### Étape 1 : Récupérer le fichier PCAP

```bash
scp -P 4242 level02@localhost:/home/user/level02/level02.pcap ~/Desktop/
```

### Étape 2 : Analyser avec Wireshark

```bash
# Ouvrir le fichier avec Wireshark
open -a Wireshark level02.pcap
```

### Étape 3 : Suivre le flux TCP

1. Dans Wireshark, clic droit sur un paquet
2. **Follow** → **TCP Stream**
3. Observer la conversation réseau

### Étape 4 : Analyser les données capturées

On trouve dans le flux :

```
ft_wandr...NDRel.L0L
```

Les **points** (`.`) dans Wireshark représentent des **caractères non-imprimables**.

### Étape 5 : Identifier les caractères cachés

En regardant la vue hexadécimale, les `.` correspondent au code **0x7F** :

- **0x7F** = caractère **DEL** (Delete/Backspace) en ASCII
- Chaque DEL supprime le caractère précédent

### Étape 6 : Reconstruire le mot de passe

Simulation de la saisie utilisateur :

```
Saisie:     f t _ w a n d r [DEL] [DEL] [DEL] [DEL] [DEL] [DEL] N D R e l [DEL] L 0 L
            ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓  ←─────supprime 6 caractères─────  ↓ ↓ ↓ ↓ ↓  ←─  ↓ ↓ ↓
Résultat:   f t _ w a                                           N D R e     L 0 L
```

En appliquant les suppressions :

- `ft_wandr` → on supprime les 6 derniers caractères avec les DEL → `ft_wa`
- On ajoute `NDRel` → `ft_waNDRel`
- On supprime le `l` avec le DEL → `ft_waNDRe`
- On ajoute `L0L` → `ft_waNDReL0L`

**Flag** : `ft_waNDReL0L`

## Explication

Ce niveau illustre les dangers du trafic réseau **non chiffré**. Les protocoles comme Telnet ou FTP transmettent les données en clair, y compris les mots de passe et les frappes clavier (incluant les backspaces). C'est pourquoi les protocoles modernes utilisent le chiffrement (HTTPS, SSH, SFTP).
