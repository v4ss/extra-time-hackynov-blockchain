# Extra Time : Hacky'Nov Blockchain challenges

<div align="center">
  <a href="https://hackynov.fr"><img src="./Keccak/img/Logo+Texte-Hacky&apos;Nov-Depths-White.svg" alt="Hacky'Nov" width="50%"></a>
</div>

| Challenge name | Categories | Description |
|--------------- | ---------- | ----------- |
| [TutoBlockchain](https://github.com/v4ss/extra-time-hackynov-blockchain/tree/main/TutoBlockchain)     | Blockchain | Tout est dit sur la page :) A vous de jouer !                                                                                                                                                                                              |
| [The Lost Treasure](https://github.com/v4ss/extra-time-hackynov-blockchain/tree/main/TheLostTreasure) | Blockchain | Vous allez devoir utiliser des fonctions spécifiques du contrat intelligent pour trouver et récupérer un coffre submergé au fond de l'océan ... Déplacez-vous à l'endroit indiqué par la carte pour réussir le challenge. |
| [Keccak](https://github.com/v4ss/extra-time-hackynov-blockchain/tree/main/Keccak)                     | Blockchain | Votre mission est de devenir propriétaire de ce contrat intelligent. Sa propriété est protégée par un mécanisme de vérification unique basé sur le hashage et la connaissance de la Blockchain.                           |
| [Fightoo](https://github.com/v4ss/extra-time-hackynov-blockchain/tree/main/Fightoo)                   | Blockchain | Vous allez devoir parier sur des combats et gagner 10 fois d'affilé ! Vous avez intérêt à être très chanceux ...                                                                                                                           |
| [Auction House](https://github.com/v4ss/extra-time-hackynov-blockchain/tree/main/AuctionHouse)        | Blockchain | Votre but est de gagner l'enchère organisée par les pirates de la LockSea. Ils ont amassé un beau butin mais certains de ces pirates ne sont peut-être pas très fidèle à leur équipage. Devenez le topBidder pour remporter le challenge ! |
| [Keccak_2](https://github.com/v4ss/extra-time-hackynov-blockchain/tree/main/Keccak_2)                 | Blockchain | Vous allez devoir récupérer un nombre secret en analysant le code du contrat. Votre but est de devenir "owner" du contrat en utilisant vos connaissances sur la Blockchain.                                                                |
| [Storage](https://github.com/v4ss/extra-time-hackynov-blockchain/tree/main/Storage)                   | Blockchain | Vous allez devoir récupérer un nombre secret en analysant le code du contrat. Votre but est de devenir "owner" du contrat en utilisant vos connaissances sur la Blockchain.                                                                |
| [Tracker](https://github.com/v4ss/extra-time-hackynov-blockchain/tree/main/Tracker)                   | Blockchain | Vous allez devoir récupérer un nombre secret en analysant le code du contrat. Votre but est de devenir "owner" du contrat en utilisant vos connaissances sur la Blockchain.                                                                |
| [Writer](https://github.com/v4ss/extra-time-hackynov-blockchain/tree/main/Writer)                     | Blockchain | Utilisez vos connaissances sur la blockchain pour devenir owner de l'instance du contrat WriterTarget que vous pourrez déployer sous certaines conditions.                                                                                 |

## Getting started

Avant de lancer les containers docker, vous devez renseigner quelques variables d'environnement.

Chaques répertoires de challenges se présente de cette façon :

```
<challenge-name>/
├─ challenge/
│  ├─ .env.example
│  ├─ <sources-files-and-folders>
├─ contracts/
│  ├─ <foundry-project-for-contracts>
├─ docker-compose.yml
├─ Dockerfile.back
├─ Dockerfile.front
```

Il faudra renommer le `.env.example` en `.env` et renseigner les deux variables manquantes qui sont :

- `PRIVATE_KEY` : Une clé privée d'un wallet sans aucun fond et que vous n'utilsierai jamais ! (servira simplement à appeler des function view)
- `SEPOLIA_RPC_URL` : L'adresse RPC d'un noeud pour intéragir avec le réseau Sepolia (Voir des node providers comme Alchemy ou Infura)

Une fois cela fait, vous pouvez lancer le container docker :

```bash
cd <chall-name>
docker compose up -d --build
```

Le container est lancé, vous pouvez vous amuser !

Bisous <3
