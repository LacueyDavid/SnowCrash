# Level 01 - Snowcrash

## Objectif

Trouver le mot de passe de l'utilisateur `flag01`.

## Solution

### Étape 1 : Examiner le fichier /etc/passwd

```bash
cat /etc/passwd
```

On trouve la ligne de l'utilisateur `flag01` avec un hash de mot de passe :

```
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
```

Le hash est : `42hDRfypTqqnw`

### Étape 2 : Préparer le fichier pour John

```bash
echo "42hDRfypTqqnw" > passwd
```

### Étape 3 : Cracker le hash avec John the Ripper

```bash
# Lancer John
john passwd

# Afficher le résultat
john --show passwd
```

### Résultat

`abcdefg`

### Avoir le flag

su flag01 && getflag

## Explication

Le hash `42hDRfypTqqnw` utilise l'algorithme DES Unix (format ancien de 13 caractères). John the Ripper teste différentes combinaisons et trouve rapidement que le mot de passe est `abcdefg` car il s'agit d'une séquence simple.
