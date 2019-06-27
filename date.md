#  partie 1 Créer un type Date en elm


---
##  Rappel :Différence entre type et type alias

 Un alias est un raccourci tandis que le mot clé type crée un nouveau type.

----

### Un premier exemple

```elm
Type alias Mois = String
```
 Indique simplement que mois est une chaîne de caractère

----
 
 Par contre :
```elm
Type Mois = Janvier
           |Fevrier
``` 
 Définit un nouveau type algébrique mois dont les valeurs sont uniquement celles indiquées

----

### Un second exemple :

```elm
Type alias DateAlias = {jour : Int,mois: Int, annee : Int}
``` 
---
### Quel est le problème ?

- jour est un entier relatif , or il doit être dans intervalle dépendant du mois
- mois est un entier relatif, or il doit etre compris entre 1 et 12

----

#### Illustration du problème 

```elm
{jour = 11 , mois = 12, annee = 1988} est une date valide 
```
mais
```elm
(jour = -2, mois =  36, annee = 2100) est aussi une date valide ...
```
---

## Début de solution

- Représenter les mois sous forme d une énumération
``` elm
type Mois = Janvier
            |Fevrier
            |Mars
            |Avril
            .
            .
            .
```


---

Cela ne répond qu à la moitié du problème
il faut aussi avoir un jour qui a du sens

----

 Situation à éviter :

```elm
{jour = 31 , mois = Juin, annee = 1988}
```

---

Explication  de type Maybe a 

```elm
Maybe a = Just a
         |Nothing
```

---

## Première solution

 Écrire une fonction dateValide qui renverra un Maybe de date.
 Si la date existe on aura Just date, sinon Nothing

---- 

### Illustrations

```elm
    date1 =  {jour = 28, mois = Decembre, annee = 2018} 

    date2 =  {jour = -42, mois = Decembre, annee = 1950}

{-
dateValide  date1 => Just date1

dateValide date2  => Nothing 
-}

```

---

## Autre Solution

Créer son propre type Date.
On utilisera
- newDate : le constructeur d un objet de type date à partir d un triplet DateAlias.
- dateVersAlias : l operation reciproque.   A un objet de type Date elle renvoie un triplet DateAlias
    - Utile pour récuperer les champs jour mois et année 
----

```elm

type alias Annee = Int 
type alias DateAlias  = {jour : Int ,  mois : Mois, annee: Annee}
type Date2 = D DateAlias

newDate : DateAlias -> Maybe Date2
newDate date = 
    (if cond)
    then Just (D date)
    else Nothing

dateVersAlias : Date2 -> DateAlias  
dateVersAlias (D da) = da
```

---

## Avantages

- Avec cette forme on a la garantie que pour toute date
entrée elle sera soit valide et sera traitee
soit invalide et ne renverra rien