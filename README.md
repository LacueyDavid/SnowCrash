# SnowCrash

## 📋 Description

SnowCrash est un projet de sécurité informatique de l'école 42 axé sur l'exploitation de vulnérabilités et la résolution de challenges CTF (Capture The Flag). L'objectif est de progresser à travers différents niveaux en exploitant des failles de sécurité pour récupérer des flags et accéder au niveau suivant.

## 🎯 Objectifs

- Comprendre les mécanismes de sécurité Unix/Linux
- Apprendre à identifier et exploiter des vulnérabilités
- Développer des compétences en reverse engineering
- Maîtriser l'analyse de binaires et de scripts
- Pratiquer l'escalade de privilèges

## 🔧 Compétences développées

- Analyse de code et reverse engineering
- Exploitation de vulnérabilités (buffer overflow, injection, etc.)
- Cryptographie et déchiffrement
- Manipulation de permissions et d'utilisateurs Unix
- Analyse de binaires avec GDB, ltrace, strace
- Scripts shell et programmation système

## 🚀 Utilisation

Le projet se présente sous forme d'une machine virtuelle ISO contenant 14 niveaux (level00 à level13) et un niveau final (level14).

```bash
# Se connecter via SSH au niveau souhaité
ssh levelXX@<IP> -p 4242

# Mot de passe du level00
level00
```

Chaque niveau contient un challenge à résoudre pour obtenir le mot de passe du niveau suivant.

## 📁 Structure

Chaque dossier `levelXX/` contient :

- Un README détaillant la solution du niveau
- Les fichiers et scripts nécessaires à la résolution
- Les explications des vulnérabilités exploitées

## ⚠️ Avertissement

Ce projet est à but éducatif uniquement. Les techniques présentées ne doivent être utilisées que dans un cadre légal et éthique.
