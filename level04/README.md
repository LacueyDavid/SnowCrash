# Level 04

## Analyse du script

Le fichier fourni est un script **Perl** utilisant le module **CGI**. Il semble tourner sur un serveur web local écoutant sur le port **4747**.

### Code source analysé

```perl
#!/usr/bin/perl
# localhost:4747
use CGI qw{param};
print "Content-type: text/html\n\n";
sub x {
  $y = $_[0];
  print `echo $y 2>&1`;
}
x(param("x"));
```

### Fonctionnement détaillé

1. **Serveur Web & CGI** : Le script est conçu pour être exécuté par un serveur web (indiqué par `# localhost:4747` et l'en-tête `Content-type`).
2. **Récupération de paramètre** : `param("x")` récupère la valeur du paramètre GET nommé `x` dans l'URL (ex: `?x=valeur`).
3. **Appel de fonction** : Cette valeur est passée à la fonction `x`.
4. **Exécution système (La faille)** :
   - La ligne `print \`echo $y 2>&1\`;` est critique.
   - En Perl, les backticks (`` ` ``) exécutent une commande shell système et retournent la sortie.
   - La variable `$y` (qui contient notre input) est interpolée directement dans la chaîne de commande `echo $y 2>&1`.

## La Vulnérabilité : Command Injection

Il s'agit d'une **injection de commande** classique. Le script ne nettoie pas l'entrée utilisateur avant de la passer au shell.

Si le script exécute :
`echo $y 2>&1`

Et que nous fournissons pour `$y` la valeur `; ls`, la commande finale exécutée par le shell sera :
`echo ; ls 2>&1`

Le point-virgule `;` sépare les commandes en shell. Le système va donc :

1. Exécuter `echo` (qui affiche une ligne vide).
2. Exécuter `ls` (notre commande injectée).

## Résolution

Pour récupérer le flag, nous devons exécuter la commande `getflag` avec les droits de l'utilisateur qui lance le script (probablement `flag04`).

### Payload

Nous allons injecter une commande via le paramètre `x`.

Il y a deux méthodes principales :

1. **Substitution de commande** : `$(getflag)` ou `` `getflag` ``. Le shell exécute `getflag` et `echo` affiche le résultat.
2. **Séparateur de commande** : `; getflag`. Le shell exécute `echo`, puis `getflag`.

### Commande d'exploitation

Il est préférable d'utiliser la substitution de commande qui est souvent plus propre avec `echo`.

**Attention** : Si vous utilisez `curl`, il faut bien protéger l'URL ou encoder les caractères spéciaux.

Méthode recommandée (Substitution) :

```bash
curl 'http://localhost:4747/?x=$(getflag)'
```

Méthode alternative (Séparateur - nécessite encodage URL du `;` en `%3B`) :

```bash
curl 'http://localhost:4747/?x=%3Bgetflag'
```

### Pourquoi `%3B` au lieu de `;` ?

Il y a deux raisons principales pour lesquelles `;` ne fonctionne pas directement ou pose problème :

1.  **Le Shell (Terminal)** : Si vous tapez `curl ...?x=;getflag` dans votre terminal, votre shell (bash/zsh) interprète le `;` comme la fin de la commande `curl` et le début d'une nouvelle commande `getflag`. `curl` est exécuté avec une URL incomplète, puis le shell essaie d'exécuter `getflag` localement (ce qui échoue).
2.  **Le protocole HTTP (URL Encoding)** : Dans une URL, certains caractères ont une signification spéciale. Pour envoyer le caractère littéral `;` au serveur web afin qu'il soit traité par le script Perl, il doit être encodé en `%3B`. Le serveur web reçoit `%3B`, le décode en `;`, et le passe au script Perl. Le script Perl l'insère ensuite dans la commande shell, où il agit enfin comme séparateur.

    > **Note** : C'est le standard **ASCII**. Le point-virgule `;` a le code hexadécimal `3B`. L'encodage URL consiste simplement à mettre un `%` devant le code hexadécimal du caractère (`%3B`). Vous pouvez vérifier cela avec `man ascii` dans votre terminal.

### Et `$(getflag)` c'est quoi ?

C'est de la **substitution de commande**.

Lorsque le shell rencontre `$(commande)`, il :

1.  Exécute d'abord `commande` (ici `getflag`).
2.  Remplace `$(commande)` par le **résultat** (la sortie texte) de cette commande.

Dans notre cas :

1.  Le script Perl construit la commande : `echo $(getflag) 2>&1`
2.  Le shell voit `$(getflag)`, il exécute `getflag`. Disons que le flag est `token123`.
3.  La commande devient alors : `echo token123 2>&1`
4.  `echo` affiche `token123`.

C'est souvent plus "propre" que `;` car on insère le résultat directement dans la commande `echo` existante, au lieu de casser la ligne pour lancer une nouvelle commande indépendante.

Le serveur exécutera `echo ; getflag`, et nous renverra la sortie contenant le flag.
