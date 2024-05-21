const ethers = require("ethers");
const factoryAbi = [
    {
        inputs: [],
        name: "AuctionHouseFactory__NotHacked",
        type: "error",
    },
    {
        inputs: [],
        name: "createInstance",
        outputs: [],
        stateMutability: "nonpayable",
        type: "function",
    },
    {
        inputs: [],
        name: "resetVerifState",
        outputs: [],
        stateMutability: "nonpayable",
        type: "function",
    },
    {
        inputs: [],
        name: "verifyInstance",
        outputs: [],
        stateMutability: "nonpayable",
        type: "function",
    },
    {
        inputs: [
            {
                internalType: "address",
                name: "userAddress",
                type: "address",
            },
        ],
        name: "getInstanceAddress",
        outputs: [
            {
                internalType: "address",
                name: "",
                type: "address",
            },
        ],
        stateMutability: "view",
        type: "function",
    },
    {
        inputs: [
            {
                internalType: "address",
                name: "userAddress",
                type: "address",
            },
        ],
        name: "getInstanceVerifState",
        outputs: [
            {
                internalType: "bool",
                name: "",
                type: "bool",
            },
        ],
        stateMutability: "view",
        type: "function",
    },
    {
        inputs: [],
        name: "getMyInstance",
        outputs: [
            {
                internalType: "address",
                name: "",
                type: "address",
            },
        ],
        stateMutability: "view",
        type: "function",
    },
];

require("dotenv").config();
const express = require("express");
const app = express();
const cors = require("cors");
const port = 3000;

const factoryAddress = process.env.FACTORY_ADDRESS;
const flag = process.env.FLAG;

const corsOptions = {
    origin: "*",
    credentials: true, //access-control-allow-credentials:true
    optionSuccessStatus: 200,
};

app.use(cors(corsOptions));

app.get("/", async (req, res) => {
    res.send(`Hacky'Nov Blockchain API - ${process.env.CHALL_NAME}`);
});

// Route pour récupérer le flag
app.get("/request-flag/:userAddress", async (req, res) => {
    // Récupérer l'adresse en paramètre GET
    const userAddress = req.params.userAddress;

    // Connexion au noeud Blockchain Sepolia
    const provider = new ethers.JsonRpcProvider(process.env.SEPOLIA_RPC_URL);
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

    // To load a factory contract
    const factory = new ethers.Contract(factoryAddress, factoryAbi, wallet);

    try {
        // Récupérer le VerifState
        const response = await factory.getInstanceVerifState(userAddress);

        // Si égal à TRUE, on renvoie le flag
        if (response) {
            res.send({ flag });
            return 0;
        } else {
            res.send("Challenge non validé");
            return 0;
        }
    } catch (e) {
        return 0;
    }
});
app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});
