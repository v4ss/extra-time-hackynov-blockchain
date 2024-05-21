import { ethers } from "./ethers-6.0.esm.min.js";
import { factoryAddress, factoryAbi } from "./constants.js";
import "./ajax-jquery.min.js";

// Initialisation du bool de connexion
let connected = false;

const connectButton = document.getElementById("connectButton");
const instanceButton = document.getElementById("instanceButton");
const submitButton = document.getElementById("submitButton");
const instanceAddressText = document.getElementById("instanceAddress");
const instanceContainer = document.getElementById("instanceContainer");
const flagContainer = document.getElementById("flag");

const devantButton = document.getElementById("devant");
const gaucheButton = document.getElementById("gauche");
const droiteButton = document.getElementById("droite");
const derriereButton = document.getElementById("derriere");
const undoButton = document.getElementById("undo");
const resetButton = document.getElementById("reset");

devantButton.onclick = devant;
gaucheButton.onclick = gauche;
droiteButton.onclick = droite;
derriereButton.onclick = derriere;
undoButton.onclick = undoMoving;

connectButton.onclick = connexionManagement;
instanceButton.onclick = createInstance;
submitButton.onclick = verifyInstance;

// Fonction pour vérifier si on est connecté à Sepolia
async function checkNetwork() {
    // Check Sepolia Network
    // Créer une instance du fournisseur Ethereum avec MetaMask
    const provider = new ethers.BrowserProvider(window.ethereum);
    const { name } = await provider.getNetwork();
    if (name != "sepolia") {
        alert(
            "Pour faire les challenges, merci de vous connecter au réseau de test Sepolia",
        );
        console.error(
            "Pour faire les challenges, merci de vous connecter au réseau de test Sepolia",
        );
        return false;
    } else {
        return true;
    }
}

function displayButtonManagement(connexionState) {
    if (connexionState) {
        instanceContainer.classList.remove("hide");
        submitButton.classList.remove("hide");
        instanceButton.classList.remove("hide");
    } else {
        instanceContainer.classList.add("hide");
        submitButton.classList.add("hide");
        instanceButton.classList.add("hide");
    }
}

async function displayInstanceManagement() {
    try {
        const signer = await getSigner();
        const factoryContract = new ethers.Contract(
            factoryAddress,
            factoryAbi,
            signer,
        );
        // Appeler la fonction getMyContract() pour récupérer l'adresse de l'instance
        const instanceAddress = await factoryContract.getMyInstance();
        instanceAddressText.innerHTML = instanceAddress;
    } catch (error) {
        console.error(
            "Erreur lors de la mise à jour de l'affichage de l'address de l'instance : ",
            error,
        );
    }
}

// Fonction pour se connecter au wallet MetaMask
async function connectWallet() {
    if (window.ethereum) {
        try {
            // Demander à l'utilisateur l'autorisation de se connecter à MetaMask
            await window.ethereum.request({ method: "eth_requestAccounts" });
            // Créer une instance du fournisseur Ethereum avec MetaMask
            const provider = new ethers.BrowserProvider(window.ethereum);
            // Renvoyer l'adresse du compte connecté
            const signer = await provider.getSigner();
            // Check si sur Sepolia Network
            const sepolia = await checkNetwork();
            if (sepolia == false) {
                return 0;
            }
            // Update du bouton de connexion
            connectButton.innerHTML = `Connected to ${signer.address.slice(0, 6)}...${signer.address.slice(signer.address.length - 4)}`;
            // connected passe donc a TRUE
            connected = true;

            // Gestion affichage des buttons selon connexion wallet
            displayButtonManagement(connected);

            return signer.address;
        } catch (error) {
            console.error("Error connecting to wallet:", error);
            throw error;
        }
    } else {
        connectButton.innerHTML = "Please install Metamask";
    }
}

// Fonction pour déconnecter le wallet
function disconnectWallet() {
    if (window.ethereum) {
        // Déconnexion du wallet
        connected = false;
        connectButton.innerHTML = "Connect";
        // Gestion affichage des buttons selon connexion wallet
        displayButtonManagement(connected);
    } else {
        connectButton.innerHTML = "Please install Metamask";
    }
}

// Fonction pour gérer la connexion au niveau du bouton Connect
async function connexionManagement() {
    if (connected) {
        await disconnectWallet();
    } else if (!connected) {
        await connectWallet();
    }
}

// Fonction pour faire aller le bâteau devant
async function devant() {
    // Check si Sepolia Network
    const sepolia = await checkNetwork();
    if (sepolia == false) {
        return 0;
    }
    try {
        const signer = await getSigner();
        const factoryContract = new ethers.Contract(
            factoryAddress,
            factoryAbi,
            signer,
        );
        // Appeler la fonction goForward()
        const transaction = await factoryContract.goForward();
        await transaction.wait();
        console.log("Le bâteau avance ...");
    } catch (error) {
        console.error(
            "Erreur lors du changement de position du bâteau : ",
            error,
        );
    }
}

// Fonction pour faire aller le bâteau à gauche
async function gauche() {
    // Check si Sepolia Network
    const sepolia = await checkNetwork();
    if (sepolia == false) {
        return 0;
    }
    try {
        const signer = await getSigner();
        const factoryContract = new ethers.Contract(
            factoryAddress,
            factoryAbi,
            signer,
        );
        // Appeler la fonction goLeft()
        const transaction = await factoryContract.goLeft();
        await transaction.wait();
        console.log("Le bâteau va à gauche ...");
    } catch (error) {
        console.error(
            "Erreur lors du changement de position du bâteau : ",
            error,
        );
    }
}

// Fonction pour faire aller le bâteau à droite
async function droite() {
    // Check si Sepolia Network
    const sepolia = await checkNetwork();
    if (sepolia == false) {
        return 0;
    }
    try {
        const signer = await getSigner();
        const factoryContract = new ethers.Contract(
            factoryAddress,
            factoryAbi,
            signer,
        );
        // Appeler la fonction goRight()
        const transaction = await factoryContract.goRight();
        await transaction.wait();
        console.log("Le bâteau va à droite ...");
    } catch (error) {
        console.error(
            "Erreur lors du changement de position du bâteau : ",
            error,
        );
    }
}

// Fonction pour faire aller le bâteau va derrière
async function derriere() {
    // Check si Sepolia Network
    const sepolia = await checkNetwork();
    if (sepolia == false) {
        return 0;
    }
    try {
        const signer = await getSigner();
        const factoryContract = new ethers.Contract(
            factoryAddress,
            factoryAbi,
            signer,
        );
        // Appeler la fonction goBackward()
        const transaction = await factoryContract.goBackward();
        await transaction.wait();
        console.log("Le bâteau va vers l'arrière ...");
    } catch (error) {
        console.error(
            "Erreur lors du changement de position du bâteau : ",
            error,
        );
    }
}

// Fonction pour faire annuler le dernier mouvement
async function undoMoving() {
    // Check si Sepolia Network
    const sepolia = await checkNetwork();
    if (sepolia == false) {
        return 0;
    }
    try {
        const signer = await getSigner();
        const factoryContract = new ethers.Contract(
            factoryAddress,
            factoryAbi,
            signer,
        );
        // Appeler la fonction undoMoving()
        const transaction = await factoryContract.undoMoving();
        await transaction.wait();
        console.log("Annulation du dernier mouvement");
    } catch (error) {
        console.error("Erreur lors de l'annulation du mouvement : ", error);
    }
}

// Fonction pour réinitialiser la position du bâteau
async function resetPosition() {
    // Check si Sepolia Network
    const sepolia = await checkNetwork();
    if (sepolia == false) {
        return 0;
    }
    try {
        const signer = await getSigner();
        const factoryContract = new ethers.Contract(
            factoryAddress,
            factoryAbi,
            signer,
        );
        // Appeler la fonction resetPosition()
        const transaction = await factoryContract.resetPosition();
        await transaction.wait();
        console.log("Le bâteau est revenu à sa position initiale ...");
    } catch (error) {
        console.error(
            "Erreur lors du changement de position du bâteau : ",
            error,
        );
    }
}

// Fonction pour créer une nouvelle instance avec la factory
async function createInstance() {
    // Check si Sepolia Network
    const sepolia = await checkNetwork();
    if (sepolia == false) {
        return 0;
    }
    try {
        const signer = await getSigner();
        const factoryContract = new ethers.Contract(
            factoryAddress,
            factoryAbi,
            signer,
        );
        // Appeler la fonction createInstance() sur la factory pour créer une nouvelle instance
        const transaction = await factoryContract.createInstance();
        await transaction.wait();
        // Appeler la fonction getMyContract() pour récupérer l'adresse de l'instance
        const instanceAddress = await factoryContract.getMyInstance();
        instanceAddressText.innerHTML = instanceAddress;
        console.log(`Nouvelle instance créée à l'adresse : ${instanceAddress}`);
    } catch (error) {
        console.error("Erreur lors de la création de l'instance : ", error);
    }
}

// Fonction pour vérifier une instance
async function verifyInstance() {
    // Check si Sepolia Network
    await checkNetwork();
    try {
        const signer = await getSigner();
        const factoryContract = new ethers.Contract(
            factoryAddress,
            factoryAbi,
            signer,
        );
        // Appeler la fonction verifyInstance() sur la factory pour vérifier une instance
        const response = await factoryContract.verifyInstance();
        await response.wait();
        // Si réponse positive, on va récupérer le flag
        if (response) {
            console.log("Instance vérifiée avec succès !");
            console.log(
                "Acceptez la deuxième transaction pour recevoir le flag",
            );
            console.log("Envoie du flag en cours ...");
            // Requète au back pour récupérer le flag si l'instance est bien vérifiée
            $.ajax({
                type: "GET",
                url: `http://localhost:20007/request-flag/${signer.address}`,
            }).done(async function (data) {
                // On reset le state de l'utilisateur
                const transaction = await factoryContract.resetVerifState();
                await transaction.wait();

                const reset = await factoryContract.getInstanceVerifState(
                    signer.address,
                );
                if (reset) {
                    console.error(
                        "Confirmez les deux transactions pour récupérer le flag",
                    );
                    return 0;
                }
                // Challenge réussi, on affiche le flag
                console.log(
                    `Bravo, vous avez réussi ! Le flag est : ${data.flag}`,
                );
                flagContainer.innerHTML = `Bravo, vous avez réussi ! Le flag est : ${data.flag}`;
            });
        } else {
            console.log(
                "Challenge non réussi ... Essayez encore ou déployez une nouvelle instance pour recommencer de zéro.",
            );
        }
    } catch (error) {
        console.error("Erreur lors de la vérification : ", error);
    }
}

// Fonction utilitaire pour récupérer le signer
async function getSigner() {
    const provider = new ethers.BrowserProvider(window.ethereum);
    return await provider.getSigner();
}

// Connexion du wallet lors du chargement de la page
window.addEventListener("load", async () => {
    try {
        displayButtonManagement(connected);
        await displayInstanceManagement();
        if (!connected) {
            const connectedAddress = await connectWallet();
        }
    } catch (error) {
        console.error("Error connecting to wallet:", error);
    }
});
