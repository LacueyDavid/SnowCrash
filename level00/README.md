# Level 00

### Étape 1 : Localiser le fichier

```bash
find / -user flag00 2> /dev/null
```

Résultat : `/usr/sbin/john`

### Étape 2 : Afficher le contenu

```bash
cat /usr/sbin/john
```

Résultat : `cdiiddwpgswtgt`

### Étape 3 : Décoder (ROT+15)

Application d'un décalage ROT+15 sur `cdiiddwpgswtgt` via [dcode.fr](https://dcode.fr)

**Flag00 password** : `nottoohardhere`
